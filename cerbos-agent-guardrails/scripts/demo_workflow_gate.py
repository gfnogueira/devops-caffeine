from agent.authz import AgentIdentity
from agent.workflows import gate, load_workflows


PERSONAS = [
    AgentIdentity(id="agent-1", persona="tier1", tenant="acme"),
    AgentIdentity(id="agent-2", persona="tier2", tenant="acme"),
    AgentIdentity(id="agent-3", persona="admin", tenant="acme"),
]


def main() -> None:
    workflows = load_workflows()
    header = f"{'persona':<8}" + "".join(f"{n:<22}" for n in workflows)
    print(header)
    for identity in PERSONAS:
        row = f"{identity.persona:<8}"
        for name in workflows:
            verdict = "ALLOW" if gate(identity, name, workflows) else "deny "
            row += f"{verdict:<22}"
        print(row)


if __name__ == "__main__":
    main()
