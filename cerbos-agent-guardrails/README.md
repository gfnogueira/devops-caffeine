# cerbos-agent-guardrails

Cerbos as the guardrail layer for an LLM agent. Two enforcement points sit in
front of the model.

**Tool gate.** Every tool the agent wants to call passes through the PDP
before it runs. Personas map to a distinct set of tools; unauthorized calls
never reach the tool implementation.

**Row level RAG filter.** Documents pulled from the corpus are filtered by
Cerbos before they land in the prompt. A tier1 persona sees only public docs
from their own tenant, never PII, never another tenant's records.

## Personas

    tier1_persona   read the KB, open low value tickets
    tier2_persona   above, plus refund up to 500
    admin_persona   the full tool set

## Run

    make up
    python -m scripts.demo_tool_gate
    python -m scripts.demo_rag_filter
    make down

## Layout

    pdp/                cerbos server config
    policies/           resource policies plus derived roles
    policies/verify/    policy tests
    agent/              authz wrapper, tool gate, rag filter
    data/               tool registry and doc corpus
    scripts/            demo runners
