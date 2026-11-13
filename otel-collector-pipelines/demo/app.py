import random
import time

from fastapi import FastAPI, HTTPException
from opentelemetry import metrics, trace
from opentelemetry.exporter.otlp.proto.grpc.metric_exporter import OTLPMetricExporter
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor

resource = Resource.create()

provider = TracerProvider(resource=resource)
provider.add_span_processor(BatchSpanProcessor(OTLPSpanExporter(insecure=True)))
trace.set_tracer_provider(provider)

reader = PeriodicExportingMetricReader(
    OTLPMetricExporter(insecure=True),
    export_interval_millis=5000,
)
metrics.set_meter_provider(MeterProvider(resource=resource, metric_readers=[reader]))

tracer = trace.get_tracer("payments")
meter = metrics.get_meter("payments")
requests_total = meter.create_counter("payments_requests_total")
latency_ms = meter.create_histogram("payments_latency_ms", unit="ms")

app = FastAPI()
FastAPIInstrumentor.instrument_app(app)


@app.get("/healthz")
def healthz():
    return {"ok": True}


@app.post("/pay")
def pay():
    start = time.time()
    with tracer.start_as_current_span("charge.authorize") as span:
        delay = random.uniform(0.02, 0.4)
        time.sleep(delay)
        span.set_attribute("charge.delay_ms", int(delay * 1000))
        if random.random() < 0.08:
            raise HTTPException(status_code=500, detail="gateway timeout")
    dur = (time.time() - start) * 1000
    requests_total.add(1, {"op": "pay"})
    latency_ms.record(dur, {"op": "pay"})
    return {"charged": True, "ms": dur}


@app.post("/refund")
def refund():
    start = time.time()
    with tracer.start_as_current_span("refund.issue"):
        time.sleep(random.uniform(0.05, 0.6))
    dur = (time.time() - start) * 1000
    requests_total.add(1, {"op": "refund"})
    latency_ms.record(dur, {"op": "refund"})
    return {"refunded": True, "ms": dur}
