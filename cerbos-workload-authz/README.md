# cerbos-workload-authz

Cerbos PDP deciding whether a non-human caller — a service, batch job, or CI
runner — may invoke an action against a target resource. The PDP only
decides; how the identity was proven (mTLS, SPIFFE, OIDC token) is upstream.

**In scope.** Workload identities for service-to-service calls, GitHub Actions
runner tokens, scheduled jobs.

**Out of scope.** Human authz, token issuance and rotation, mesh wiring.

## Run

    task up
    task ping
    task check:allow
    task check:deny
    task down

## Layout

    stack/cerbos/   PDP server config
    policies/       resource policies and derived roles
    checks/         request payloads used by task check:*
