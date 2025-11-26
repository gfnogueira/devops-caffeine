const express = require('express');
const redis = require('redis');
const crypto = require('crypto');

const app = express();
const port = process.env.PORT || 3000;
const voteTTL = parseInt(process.env.VOTE_TTL) || 3600; // 1 hour default

// Middleware
app.use(express.json());

// Redis client
const redisClient = redis.createClient({
  url: process.env.REDIS_URL || 'redis://localhost:6379'
});

redisClient.connect().catch(console.error);

// Lua script for atomic deduplication
// KEYS[1] = vote fingerprint key
// KEYS[2] = candidate counter key
// ARGV[1] = TTL in seconds
const DEDUPE_SCRIPT = `
local fingerprint = KEYS[1]
local candidate_key = KEYS[2]
local ttl = tonumber(ARGV[1])

-- Check if vote already exists
if redis.call('EXISTS', fingerprint) == 1 then
    return 0  -- Duplicate vote detected
end

-- Store fingerprint and increment counter atomically
redis.call('SETEX', fingerprint, ttl, '1')
redis.call('INCR', candidate_key)

return 1  -- New vote recorded successfully
`;

// Generate vote fingerprint
function generateFingerprint(userId, candidate, timeWindow) {
  const data = `${userId}:${candidate}:${timeWindow}`;
  return crypto.createHash('sha256').update(data).digest('hex');
}

// Get current time window (1-hour buckets)
function getTimeWindow() {
  const now = Date.now();
  const hourInMs = 60 * 60 * 1000;
  return Math.floor(now / hourInMs);
}

// Health check
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'healthy', 
    timestamp: new Date().toISOString(),
    redis: redisClient.isOpen ? 'connected' : 'disconnected'
  });
});

// Submit vote with atomic deduplication
app.post('/vote', async (req, res) => {
  try {
    const { userId, candidate } = req.body;

    // Validation
    if (!userId) {
      return res.status(400).json({ 
        error: 'userId is required',
        success: false
      });
    }

    if (!candidate || !['A', 'B', 'C'].includes(candidate)) {
      return res.status(400).json({ 
        error: 'Invalid candidate. Must be A, B, or C',
        success: false
      });
    }

    // Generate fingerprint based on userId, candidate, and time window
    const timeWindow = getTimeWindow();
    const fingerprint = generateFingerprint(userId, candidate, timeWindow);
    
    const fingerprintKey = `vote:fp:${fingerprint}`;
    const candidateKey = `vote:count:${candidate}`;

    // Execute Lua script atomically
    const result = await redisClient.eval(DEDUPE_SCRIPT, {
      keys: [fingerprintKey, candidateKey],
      arguments: [voteTTL.toString()]
    });

    if (result === 0) {
      // Duplicate vote detected
      console.log(`Duplicate vote rejected: userId=${userId}, candidate=${candidate}, fingerprint=${fingerprint.substring(0, 8)}...`);
      
      return res.status(409).json({
        success: false,
        message: 'Duplicate vote detected',
        duplicate: true,
        userId,
        candidate
      });
    }

    // New vote recorded
    console.log(`Vote recorded: userId=${userId}, candidate=${candidate}, fingerprint=${fingerprint.substring(0, 8)}...`);

    res.status(201).json({
      success: true,
      message: 'Vote recorded successfully',
      duplicate: false,
      userId,
      candidate,
      fingerprintPreview: fingerprint.substring(0, 16) + '...'
    });

  } catch (error) {
    console.error('Error processing vote:', error);
    res.status(500).json({ 
      error: 'Internal server error',
      success: false
    });
  }
});

// Get current results
app.get('/results', async (req, res) => {
  try {
    const [countA, countB, countC] = await Promise.all([
      redisClient.get('vote:count:A'),
      redisClient.get('vote:count:B'),
      redisClient.get('vote:count:C')
    ]);

    const votes = {
      A: parseInt(countA) || 0,
      B: parseInt(countB) || 0,
      C: parseInt(countC) || 0
    };

    const total = votes.A + votes.B + votes.C;

    res.status(200).json({
      votes,
      total,
      percentages: {
        A: total > 0 ? ((votes.A / total) * 100).toFixed(2) : 0,
        B: total > 0 ? ((votes.B / total) * 100).toFixed(2) : 0,
        C: total > 0 ? ((votes.C / total) * 100).toFixed(2) : 0
      }
    });

  } catch (error) {
    console.error('Error getting results:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Get deduplication stats
app.get('/stats', async (req, res) => {
  try {
    // Count fingerprint keys
    const fingerprintKeys = await redisClient.keys('vote:fp:*');
    const uniqueVotes = fingerprintKeys.length;

    const [countA, countB, countC] = await Promise.all([
      redisClient.get('vote:count:A'),
      redisClient.get('vote:count:B'),
      redisClient.get('vote:count:C')
    ]);

    const totalVotes = (parseInt(countA) || 0) + (parseInt(countB) || 0) + (parseInt(countC) || 0);

    res.status(200).json({
      uniqueVotes,
      totalVotes,
      isConsistent: uniqueVotes === totalVotes,
      fingerprintKeys: fingerprintKeys.length,
      ttl: voteTTL
    });

  } catch (error) {
    console.error('Error getting stats:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Reset votes (for testing only)
app.post('/reset', async (req, res) => {
  try {
    await redisClient.flushDb();
    console.log('All votes and fingerprints reset');
    
    res.status(200).json({ 
      success: true, 
      message: 'All data reset' 
    });
  } catch (error) {
    console.error('Error resetting:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Graceful shutdown
process.on('SIGTERM', async () => {
  console.log('SIGTERM received, closing server...');
  await redisClient.quit();
  process.exit(0);
});

app.listen(port, () => {
  console.log(`Voting API with Lua deduplication listening on port ${port}`);
  console.log(`Vote TTL: ${voteTTL} seconds`);
});
