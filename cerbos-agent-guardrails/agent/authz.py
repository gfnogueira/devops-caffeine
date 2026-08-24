import os
from dataclasses import dataclass, field

from cerbos.sdk.client import CerbosClient
from cerbos.sdk.model import Principal, Resource, ResourceList


PDP_HOST = os.getenv("PDP_HOST", "http://localhost:3592")


@dataclass
class AgentIdentity:
    id: str
    persona: str
    tenant: str
    roles: set = field(default_factory=lambda: {"agent_persona"})

    def as_principal(self) -> Principal:
        return Principal(
            id=self.id,
            roles=self.roles,
            attr={"persona": self.persona, "tenant": self.tenant},
        )


def is_allowed(identity: AgentIdentity, action: str, resource: Resource) -> bool:
    with CerbosClient(host=PDP_HOST) as client:
        return client.is_allowed(action, identity.as_principal(), resource)


def filter_resources(identity: AgentIdentity, action: str, resources: list[Resource]) -> list[Resource]:
    if not resources:
        return []
    with CerbosClient(host=PDP_HOST) as client:
        batch = ResourceList().add(resources[0], {action})
        for r in resources[1:]:
            batch.add(r, {action})
        result = client.check_resources(identity.as_principal(), batch)
    kept = []
    for r in resources:
        decision = result.get_resource(r.id)
        if decision and decision.is_allowed(action):
            kept.append(r)
    return kept
