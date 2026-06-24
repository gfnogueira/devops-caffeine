# tetragon-runtime-enforcement

Field notes from running Tetragon as an in-cluster runtime sensor and (later)
enforcer. PoC layered to keep "observe" and "enforce" obviously separate so
neither bleeds into the other by accident.

## Two-step migration

1. **Observe.** Baseline TracingPolicies emit events; nothing is killed.
2. **Enforce.** A separate set of policies attaches `SigKill` to specific
   subjects. Roll forward one policy at a time, never the whole set.

## Stack

- `kind` cluster (`tetragon-poc`)
- Tetragon DaemonSet via the cilium/tetragon Helm chart
- TracingPolicy CRDs scoped to the `evaluation` namespace

## Quickstart

```sh
just up        # kind + Helm
just events    # tail events from every node
just status    # daemonset and loaded policies
just down
```
