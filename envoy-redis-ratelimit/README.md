# Envoy + Redis Rate Limiting

## Objective

Implement progressive rate limiting at the edge using **Envoy Proxy** as an edge gateway and **Redis** as the rate limiting backend. This PoC demonstrates API abuse protection with per-IP and per-token rate limiting, including load testing and observability metrics.

## Architecture

```
┌─────────────┐
│   Client    │
└──────┬──────┘
       │
       ▼
┌─────────────────────────────────┐
│      Envoy Proxy (Edge)         │
│  - Rate Limit Filter            │
│  - Global Rate Limit Service    │
└──────┬──────────────────┬───────┘
       │                  │
       │                  ▼
       │          ┌──────────────┐
       │          │    Redis     │
       │          │ (Rate Limit) │
       │          └──────────────┘
       ▼
┌─────────────┐
│  Voting API │
│  (Backend)  │
└─────────────┘
```

## Technologies

- **Envoy Proxy** - Edge gateway with rate limiting filter
- **Redis** - Backend for rate limit counters
- **Docker Compose** - Local orchestration
- **k6** - Load testing and rate limit validation
- **Prometheus** (optional) - Metrics and observability

## Features

- Rate limiting per IP (e.g., 10 req/min)
- Rate limiting per token/user (e.g., 100 req/min)
- Progressive rate limiting (different limits per route)
- Metrics for blocking and false positives
- Automated tests with k6

## How to Use

### 1. Start the stack

```bash
docker-compose up -d
```

### 2. Test rate limit manually

```bash
# Basic test
curl http://localhost:8080/vote -d '{"candidate":"A"}' -H "Content-Type: application/json"

# Burst test (should block after limit)
for i in {1..20}; do curl http://localhost:8080/vote -d '{"candidate":"A"}'; done
```

### 3. Run load tests

```bash
k6 run tests/ratelimit-test.js
```

### 4. View metrics

- Envoy Admin: http://localhost:9901
- Redis CLI: `docker exec -it redis redis-cli`

## Testing and Validation

### Test Scenarios

1. **Normal burst** - Validate that requests within the limit pass
2. **Burst above limit** - Validate blocking (HTTP 429)
3. **Rate limit per IP** - Multiple IPs should have independent limits
4. **Rate limit per token** - Different tokens have separate limits
5. **False positives** - Measure % of legitimate requests blocked

### Expected Metrics

- Blocking rate: >95% for requests above the limit
- False positives: <1%
- Additional latency: <10ms (p95)

## Learnings and Technical Decisions

### Why Envoy?

- Modern proxy, used in service mesh (Istio, Consul)
- Native rate limiting with Redis integration
- Built-in observability (metrics, traces)
- Used in production by companies like Lyft, Airbnb

### Why Redis for rate limiting?

- Atomic operations (INCR, EXPIRE)
- High performance (>100k ops/s)
- Automatic TTL for rate limit windows
- Widely used in production

### Alternatives considered

- **nginx + lua-resty-limit-traffic** - Lighter, but fewer features
- **Kong** - More complete, but higher overhead for PoC
- **Traefik** - Basic rate limiting, less flexible

## References

- [Envoy Rate Limiting](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/rate_limit_filter)
- [Envoy Rate Limit Service](https://github.com/envoyproxy/ratelimit)
- [Redis Rate Limiting Patterns](https://redis.io/docs/manual/patterns/rate-limiter/)

## Next Steps

- [ ] Add adaptive rate limiting (based on latency)
- [ ] Implement circuit breaker in Envoy
- [ ] Integrate with Prometheus + Grafana
- [ ] Test with multiple backends (load balancing)

## Author

Guilherme Nogueira - [GitHub](https://github.com/gfnogueira)
