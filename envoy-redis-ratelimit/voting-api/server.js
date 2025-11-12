const express = require('express');
const redis = require('redis');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

const redisClient = redis.createClient({
  url: process.env.REDIS_URL || 'redis://localhost:6379'
});

redisClient.connect().catch(console.error);

// In-memory vote counter 
const votes = {
  A: 0,
  B: 0,
  C: 0
};


app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// Vote endpoint
app.post('/vote', async (req, res) => {
  try {
    const { candidate } = req.body;
    const userId = req.headers['x-user-id'] || 'anonymous';
    const ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;

    if (!candidate || !['A', 'B', 'C'].includes(candidate)) {
      return res.status(400).json({ 
        error: 'Invalid candidate. Must be A, B, or C' 
      });
    }

    votes[candidate]++;

    console.log(`Vote received: candidate=${candidate}, user=${userId}, ip=${ip}, total=${votes[candidate]}`);

    // Store in Redis 
    const voteKey = `vote:${userId}:${Date.now()}`;
    await redisClient.set(voteKey, JSON.stringify({
      candidate,
      userId,
      ip,
      timestamp: new Date().toISOString()
    }), { EX: 3600 });

    res.status(201).json({ 
      success: true, 
      candidate,
      message: 'Vote recorded successfully'
    });

  } catch (error) {
    console.error('Error processing vote:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/results', (req, res) => {
  const total = Object.values(votes).reduce((sum, v) => sum + v, 0);
  
  res.status(200).json({
    votes,
    total,
    percentages: {
      A: total > 0 ? ((votes.A / total) * 100).toFixed(2) : 0,
      B: total > 0 ? ((votes.B / total) * 100).toFixed(2) : 0,
      C: total > 0 ? ((votes.C / total) * 100).toFixed(2) : 0
    }
  });
});

// Reset votes
app.post('/reset', (req, res) => {
  votes.A = 0;
  votes.B = 0;
  votes.C = 0;
  
  console.log('Votes reset');
  res.status(200).json({ success: true, message: 'Votes reset' });
});

process.on('SIGTERM', async () => {
  console.log('SIGTERM received, closing server...');
  await redisClient.quit();
  process.exit(0);
});

app.listen(port, () => {
  console.log(`Voting API listening on port ${port}`);
});
