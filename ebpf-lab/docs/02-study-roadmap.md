# Study roadmap

Phased plan for this lab. Each phase has a clear outcome; skip ahead only if you already meet the outcome.

## Phase overview

| Phase | Topic | Outcome | Effort |
| --- | --- | --- | --- |
| 0 | This doc + fundamentals | Explain program, map, verifier, attach point | Read only |
| 1 | Falco PoC (sibling lab) | See eBPF-backed events without writing BPF | Hands-on |
| 2 | bpftrace in `examples/` | Trace `execve`, opens, or counts by comm | Light scripts |
| 3 | Compare runtimes | Note Falco vs Tetragon-style enforcement (docs/readme) | Reading |
| 4 | Minimal libbpf or Go ebpf | Load one trivial program (optional, later) | Medium |

## Phase 0 — Vocabulary

- [ ] Read [01-fundamentals.md](01-fundamentals.md)
- [ ] Skim [ebpf.io what is eBPF](https://ebpf.io/what-is-ebpf/)

## Phase 1 — Runtime security (existing PoC)

```bash
cd falco-runtime-security
cp .env.example .env
make up
make simulate
make validate
```

- [ ] Confirm events in Falco logs / Sidekick UI
- [ ] Map one simulation script to the rule it triggers (see `falco-runtime-security/README.md`)

## Phase 2 — bpftrace (planned)

Scripts will land under `examples/`. Target exercises:

- List new processes (`execve`) for 30 seconds
- Count syscalls by process name
- Watch opens under a path prefix

Requires Linux + `bpftrace` on the host used for tracing.

## Phase 3 — Broader landscape (reading)

- [ ] Falco architecture and driver choice
- [ ] [Tetragon](https://github.com/cilium/tetragon) — eBPF security observability and enforcement
- [ ] When to prefer productized eBPF vs custom programs (team skill, kernel support, compliance)

## Phase 4 — Optional depth

Defer until Phases 0–2 are comfortable:

- libbpf bootstrap or a small [cilium/ebpf](https://github.com/cilium/ebpf) Go loader
- CO-RE and BTF on your target kernel/distro

## Success criteria (initial track)

You can describe how Falco’s eBPF path relates to syscalls, run the Falco harness successfully, and read a bpftrace script without guessing every keyword. Writing production BPF can wait for Phase 4.
