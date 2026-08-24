from pathlib import Path

import yaml
from cerbos.sdk.model import Resource

from .authz import AgentIdentity, is_allowed


TOOL_REGISTRY = Path(__file__).resolve().parent.parent / "data" / "tools.yaml"


def load_tools() -> dict[str, dict]:
    with TOOL_REGISTRY.open() as f:
        raw = yaml.safe_load(f)
    return {t["name"]: t for t in raw["tools"]}


def gate(identity: AgentIdentity, tool_name: str, tools: dict[str, dict]) -> bool:
    spec = tools.get(tool_name)
    if not spec:
        raise KeyError(f"unknown tool: {tool_name}")
    resource = Resource(
        id=spec["name"],
        kind="tool",
        attr={
            "name": spec["name"],
            "risk": spec["risk"],
            "max_amount": spec.get("max_amount", 0),
        },
    )
    return is_allowed(identity, "invoke", resource)
