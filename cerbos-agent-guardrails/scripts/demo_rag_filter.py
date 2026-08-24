from agent.authz import AgentIdentity
from agent.rag import retrieve


PERSONAS = [
    AgentIdentity(id="agent-1", persona="tier1", tenant="acme"),
    AgentIdentity(id="agent-2", persona="tier2", tenant="acme"),
    AgentIdentity(id="agent-3", persona="admin", tenant="acme"),
    AgentIdentity(id="agent-4", persona="tier1", tenant="globex"),
]


def main() -> None:
    for identity in PERSONAS:
        hits = retrieve(identity, "policy")
        print(f"\npersona={identity.persona} tenant={identity.tenant}")
        for h in hits:
            print(f"  {h['id']} label={h['label']:<8} tenant={h['tenant']}")


if __name__ == "__main__":
    main()
