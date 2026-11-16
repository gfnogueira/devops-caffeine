# otel-collector-pipelines

A compose stack for exploring the OpenTelemetry Collector. One
receiver layer (OTLP on 4317 and 4318), three pipeline variants
that trade off fidelity for cost, and a Grafana that stitches
traces to metrics via exemplars.

## Stack

| Piece | Role |
|---|---|
| otel-collector-contrib 0.111 | receivers, processors, exporters |
| tempo 2.6 | trace backend, OTLP ingest on 4318, TraceQL on 3200 |
| prometheus 2.55 | scrapes the collector's prometheus exporter on :8889 |
| grafana 11.3 | pre provisioned Tempo and Prometheus data sources |
| payments demo | fastapi app with the OTel SDK, spans around /pay and /refund |

## Tour

### 1. Baseline

    task up
    task fire -- 300

The baseline config is `otelcol/baseline.yaml`. OTLP in, batch,
otlphttp out to Tempo on the traces side, prometheus exporter
scraped on the metrics side. Everything the demo emits lands in
the backends untouched.

Open Grafana at http://localhost:3000. The Tempo data source
answers `{service.name="payments"}`. The Prometheus data source
answers `rate(otel_payments_requests_total[1m])`.

### 2. Processors

    task processors
    task fire -- 300

Swaps the collector onto `otelcol/with-processors.yaml`. Three
processors join the traces pipeline:

- `resource` stamps every signal with `deployment.cluster` and
  `telemetry.source`
- `attributes/scrub` drops the authorization header and
  `user.email` before data leaves the collector
- `filter/healthz` removes /healthz spans from the traces
  pipeline so probe traffic does not clutter Tempo

Metrics on the probe stay untouched so the 70/20/10 split in
`fire-traffic.sh` still shows the healthz line on the counter.

### 3. Tail sampling

    task sampling
    task fire -- 400

Swaps the collector onto `otelcol/tail-sampling.yaml`. The
tail_sampling processor sits before batch and runs three
policies in order: `status_code ERROR` keeps every failed trace,
`latency` over 500ms keeps anything slow, and a 5 percent
probabilistic sample keeps a floor so the dashboards do not
empty out.

`decision_wait` is 10s. That is how long the processor holds
spans before it decides, so wall clock Tempo lag goes up by 10s
on this config. Not something to ship without a plan for long
tail spans that outlive the window.

## Tasks

| Task | What it does |
|---|---|
| `up` | docker compose up with build |
| `down` | compose down with volume drop |
| `baseline`, `processors`, `sampling` | swap the collector onto a variant |
| `fire` | run `recipes/fire-traffic.sh` with its args (iterations) |
| `logs` | tail the collector logs |

## Troubleshooting

Collector not starting? `task logs` prints the YAML it refuses.
Most errors here come from the processor list in
`service.pipelines` referencing a processor name the `processors`
block never declared.

Tempo answering with 404 on TraceQL search? Wait 30s after
`task up` for the WAL to flush. Blocks only become searchable
after `max_block_duration` which is 5m but the WAL covers that
window in the meantime.

Prometheus has the collector target DOWN? Check that the
collector container is reachable from prometheus with
`docker exec prometheus wget -qO- http://otelcol:8889/metrics`.
