from pathlib import Path

import yaml
from cerbos.sdk.model import Resource

from .authz import AgentIdentity, is_allowed


WORKFLOW_REGISTRY = Path(__file__).resolve().parent.parent / "data" / "workflows.yaml"


def load_workflows() -> dict[str, dict]:
    with WORKFLOW_REGISTRY.open() as f:
        raw = yaml.safe_load(f)
    return {w["name"]: w for w in raw["workflows"]}


def gate(identity: AgentIdentity, workflow_name: str, workflows: dict[str, dict]) -> bool:
    spec = workflows.get(workflow_name)
    if not spec:
        raise KeyError(f"unknown workflow: {workflow_name}")
    resource = Resource(
        id=spec["name"],
        kind="workflow",
        attr={"name": spec["name"], "risk": spec["risk"]},
    )
    return is_allowed(identity, "trigger", resource)
