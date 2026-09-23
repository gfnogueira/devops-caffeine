# Examples

Hands-on snippets for Phase 2 of the [study roadmap](../docs/02-study-roadmap.md).

## Planned layout

```text
examples/
├── README.md
└── bpftrace/
    └── execve_audit.bt
```

## Running

On a Linux host with `bpftrace` installed and the required tracing privileges:

```bash
sudo timeout 30s bpftrace examples/bpftrace/execve_audit.bt
```

In another terminal, generate a few events:

```bash
date
uname -a
id
```

The script attaches to the `sys_enter_execve` tracepoint, prints process
metadata for each execution, and aggregates executions by process name in a
map. Run it only on a disposable or approved Linux host; tracing requires
elevated privileges and may expose command paths or arguments.

The output helps answer basic operational questions:

- Which processes are executed during a deployment or incident?
- Which command names are unusually frequent?
- Does observed process activity match the expected workload?

## Platform note

macOS does not provide the Linux kernel tracepoints used by this example. Run
the lab inside a Linux VM or cloud instance rather than attempting to load it
on the macOS host.

## Until then

Use [falco-runtime-security](../../falco-runtime-security/) for practical syscall-level security events on containers.
