# cilium-netpol-hubble

A ladder of network policies on a kind cluster, Cilium as the CNI, Hubble
for the flow trail. Each rung tightens the gate and the next scene proves
the change.

## The rungs

1. Nothing applied, every pod talks to every pod.
2. Default deny on the `backend` namespace, intruder is cut off.
3. Allow `frontend` to reach `backend` on port 80, intruder still cut off.
4. Keep the allow but restrict HTTP to `GET /` only. POST comes back deny.
5. Egress out of `frontend` locked to a short FQDN list. Random external
   calls are refused at the DNS layer.

## Run

    env/kind.yaml                         kind cluster, no default CNI
    env/install-cilium.sh                 helm install cilium with Hubble
    kubectl apply -f apps/
    scenes/01-isolate.sh
    scenes/02-allow.sh
    scenes/03-l7-restrict.sh
    scenes/tail-flows.sh                  hubble observe
    env/teardown.sh

## Layout

    env/        kind config, cilium install, teardown
    apps/       frontend, backend, intruder namespaces
    netpol/     one policy per rung
    scenes/     short scripts that walk a rung and probe the result

## Reading a Hubble line

A compact flow line shows: timestamp, src identity, dst identity, verdict,
L4 or L7 detail. Deny lines carry a reason tag like `policy-denied`.
`scenes/tail-flows.sh backend 50` is the quickest way to pull the last fifty
for one namespace.

## When something looks wrong

If a GET fails after the L7 policy applies, confirm the request actually
reached cilium by watching the flows during the probe. A dropped connection
with no flow entry usually means the pod labels do not match the policy
`endpointSelector`. Double check with `scenes/cilium-status.sh` and verify
the endpoint carries the expected identity labels before touching the
policy YAML.
