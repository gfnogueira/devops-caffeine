from agent.authz import AgentIdentity
from agent.tools import gate, load_tools


PERSONAS = [
    AgentIdentity(id="agent-1", persona="tier1", tenant="acme"),
    AgentIdentity(id="agent-2", persona="tier2", tenant="acme"),
    AgentIdentity(id="agent-3", persona="admin", tenant="acme"),
]


def main() -> None:
    tools = load_tools()
    header = f"{'persona':<8}" + "".join(f"{n:<22}" for n in tools)
    print(header)
    for identity in PERSONAS:
        row = f"{identity.persona:<8}"
        for name in tools:
            verdict = "ALLOW" if gate(identity, name, tools) else "deny "
            row += f"{verdict:<22}"
        print(row)


if __name__ == "__main__":
    main()
