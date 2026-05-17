# Falco Runtime Security

Local Proof of Concept for runtime threat detection on containerized workloads
using Falco, the CNCF runtime security project.

## Objective

Validate a production-style Falco deployment with custom detection rules,
output routing through Falcosidekick, and a deterministic harness that proves
each rule fires against a controlled threat simulation.

## Scope

- Falco daemon with modern eBPF driver, tuned for low overhead
- Falcosidekick output broker plus Falcosidekick-UI dashboard
- Curated rule pack covering container security, secrets access, crypto mining,
  reverse shells, and persistence attempts
- Threat simulation harness to deterministically trigger each rule
- Validation workflow that parses event output and asserts coverage

## Architecture

```text
Syscalls --> Falco (modern_ebpf) --> falco-events.log
                                  +-> Falcosidekick --> Outputs --> Sidekick-UI
```

## Project Structure

```text
falco-runtime-security/
├── docker-compose.yml
├── Makefile
├── README.md
├── .env.example
├── config/
│   └── falco.yaml
├── rules/
└── scripts/
    ├── lib/
    └── simulate/
```

## Bootstrap

```bash
cd falco-runtime-security
cp .env.example .env
make up
make smoke
make logs
```
