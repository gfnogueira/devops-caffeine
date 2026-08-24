import json
from pathlib import Path

from cerbos.sdk.model import Resource

from .authz import AgentIdentity, filter_resources


CORPUS_PATH = Path(__file__).resolve().parent.parent / "data" / "docs.jsonl"


def load_corpus() -> list[dict]:
    with CORPUS_PATH.open() as f:
        return [json.loads(line) for line in f if line.strip()]


def _to_resource(doc: dict) -> Resource:
    return Resource(
        id=doc["id"],
        kind="document",
        attr={
            "tenant": doc["tenant"],
            "label": doc["label"],
            "owner": doc.get("owner"),
        },
    )


def retrieve(identity: AgentIdentity, query: str, top_k: int = 20) -> list[dict]:
    corpus = load_corpus()
    q = query.lower()
    hits = [d for d in corpus if q in d["text"].lower()][:top_k]
    resources = [_to_resource(d) for d in hits]
    allowed_ids = {r.id for r in filter_resources(identity, "read", resources)}
    return [d for d in hits if d["id"] in allowed_ids]
