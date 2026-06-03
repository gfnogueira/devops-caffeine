# eBPF fundamentals

Short reference for the study track. Depth increases in later phases; nothing here requires writing BPF bytecode yet.

## What eBPF is

eBPF lets the Linux kernel run **verified, sandboxed programs** in response to events (network packets, syscalls, tracepoints, and more). User space loads bytecode; the **verifier** rejects unsafe programs before attach.

Typical properties:

- **Low overhead** compared to many userspace agents polling the kernel
- **Attach at the source** of events (e.g. syscall entry) instead of only parsing logs downstream
- **Same mechanism, many use cases**: observability, security, networking, performance

## Core building blocks

| Concept | Role |
| --- | --- |
| **Program** | Logic that runs when an event fires (e.g. trace syscall `execve`) |
| **Map** | Kernel-side key/value store shared between programs and user space |
| **Helper functions** | Safe kernel APIs callable from BPF (read memory, format data, etc.) |
| **Attach point** | Where the program hooks (kprobe, tracepoint, cgroup, XDP, etc.) |
| **Verifier** | Static analysis ensuring bounded loops, valid memory access, allowed helpers |

Programs do not run arbitrary kernel code; they follow strict rules so a bug in BPF does not crash the kernel like a loadable kernel module might.

## How this repo uses eBPF today

[Falco](../falco-runtime-security/) uses an eBPF-based driver to observe syscalls and evaluate rules (containers, shells, sensitive paths, etc.). You operate Falco rules and simulations; Falco owns the BPF layer.

This lab explains **what sits underneath** so later tools (bpftrace, Tetragon, custom tracers) feel familiar.

## Security-relevant attach ideas (conceptual)

| Attach style | Typical security use |
| --- | --- |
| Syscall tracepoints / kprobes | Process start, file open, network connect |
| cgroup hooks | Per-container policy and visibility |
| LSM BPF | Authorization decisions (newer kernels, policy engines) |

Exact availability depends on kernel version and distribution.

## Tooling ladder (preview)

1. **bpftrace** — one-liners and scripts for exploration (next step in `examples/`)
2. **libbpf / CO-RE** — portable programs shipped as binaries (later)
3. **Products** — Falco, Tetragon, Cilium embed eBPF so you focus on policy and ops

## Glossary

- **BCC** — older Python/Lua frontend generating BPF; still common in tutorials
- **CO-RE** — Compile Once, Run Everywhere; BPF programs adapt to different kernel layouts via BTF
- **BTF** — BPF Type Format; debug info used for CO-RE and introspection
