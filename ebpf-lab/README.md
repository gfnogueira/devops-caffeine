# eBPF Lab

Lightweight study track for extended Berkeley Packet Filter (eBPF) in a security and observability context.

## Objective

Build a shared vocabulary for eBPF (programs, maps, verifier, attach points) and prepare for hands-on work in this repo, starting with tracing tools before writing loadable programs.

## Scope (initial)

- Conceptual notes under `docs/`
- Placeholder layout under `examples/` for future `bpftrace` snippets
- Cross-reference to [falco-runtime-security](../falco-runtime-security/), which already uses Falco’s `modern_ebpf` driver

Out of scope for now: custom CO-RE binaries, production Cilium deployments, or kernel module development.

## Prerequisites

- Linux environment (VM, cloud instance, or Linux container with sufficient privileges). macOS hosts should run labs on Linux.
- Basic comfort with syscalls, processes, and containers
- Optional later: `bpftrace` installed on the lab host ([install guide](https://github.com/bpftrace/bpftrace/blob/master/INSTALL.md))

## Structure

```text
ebpf-lab/
├── README.md
├── docs/
│   ├── 01-fundamentals.md
│   └── 02-study-roadmap.md
└── examples/
    └── README.md
```

## Quick start

Read in order:

1. [docs/01-fundamentals.md](docs/01-fundamentals.md)
2. [docs/02-study-roadmap.md](docs/02-study-roadmap.md)
3. Run [falco-runtime-security](../falco-runtime-security/) if you want eBPF-backed detection without writing BPF yourself

## References

- [ebpf.io](https://ebpf.io/) — overview and documentation hub
- [bpftrace reference](https://github.com/bpftrace/bpftrace/blob/master/docs/reference_guide.md)
- [Falco docs — drivers](https://falco.org/docs/getting-started/installation/#drivers)
