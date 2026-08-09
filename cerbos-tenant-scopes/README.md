# cerbos-tenant-scopes

Per tenant authorization with Cerbos scoped policies. One base policy for the
SaaS, three tenants layering their own overrides on top.

**What's the demo?** The same request payload changes only the `scope`
field. Cerbos walks child to parent, applies tenant overrides on top of the
base, and returns a different effect per tenant.

**What's a scope?** A dotted path (`saas.acme`, `saas.globex`,
`saas.initech`) that names where in the hierarchy a rule lives.

**Which tenant does what?**
* `acme` inherits the base and adds admin only delete.
* `globex` denies approve when the contract value exceeds the principal
  approval_limit, and disables delete for compliance.
* `initech` is a free tier: create is capped at 5, export is locked behind a
  paid plan.

## Run

    bin/up.sh
    bin/ping.sh
    bin/check.sh   requests/acme_manager_approve.json
    bin/matrix.sh
    bin/down.sh

## Layout

    pdp/config.yaml            server config
    pdp/policies/              base resource policies plus derived roles
    pdp/policies/scopes/       per tenant overrides
    pdp/policies/verify/       policy tests
    requests/                  check payloads
    bin/                       scripts
