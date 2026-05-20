# Falco Runtime Security

PoC for runtime threat detection on containerized workloads
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

## Runtime Sequence

```bash
make up         # Start Falco + Falcosidekick + Falcosidekick-UI
make smoke      # Confirm Falco binary and driver are ready
make outputs    # Send synthetic events through Falcosidekick to test routing
make simulate   # Dispatch every threat simulation in sequence
make validate   # Assert each rule fired by parsing the event log
make health     # Daemon, rules, sidekick metrics, UI reachability
make bench      # Average detection latency for a sample of simulations
```

## Detection Coverage

| Category | File | Example rule |
| --- | --- | --- |
| Container security | `rules/10_container_security.yaml` | Interactive shell spawned in container |
| Secrets access | `rules/20_secrets_access.yaml` | Read of sensitive secret file |
| Crypto mining | `rules/30_crypto_mining.yaml` | Known crypto miner binary executed |
| Reverse shell | `rules/40_reverse_shell.yaml` | Reverse shell command pattern detected |
| Persistence | `rules/50_persistence.yaml` | Write to system persistence path |

## Validation Mapping

Each script in `scripts/simulate/` is mapped to the rule it must trigger inside
`scripts/lib/detection_matchers.py`. The validation harness asserts coverage by
running every simulation and confirming each expected rule appears in the Falco
event log within the configured timeout.
