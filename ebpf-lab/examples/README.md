# Examples

Hands-on snippets will be added in Phase 2 of the [study roadmap](../docs/02-study-roadmap.md).

## Planned layout

```text
examples/
├── README.md
└── bpftrace/          # forthcoming
    ├── execve.bt
    └── open_paths.bt
```

## Running (when scripts exist)

On a Linux host with bpftrace installed:

```bash
sudo bpftrace examples/bpftrace/execve.bt
```

Use a non-production environment; tracing requires elevated privileges.

## Until then

Use [falco-runtime-security](../../falco-runtime-security/) for practical syscall-level security events on containers.
