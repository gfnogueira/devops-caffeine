# cerbos-entitlements

Cerbos as the entitlement engine for a SaaS. Plan tier and billing state
answer "can this tenant use feature X" and "have they hit their quota"
without any `if plan == "pro"` living inside the product.

## The gate matrix

    feature or quota           free      pro       enterprise
    ------------------------------------------------------
    sso                        deny      deny      allow
    api_access                 deny      allow     allow
    export                     deny      allow     allow
    custom_domain              deny      deny      allow
    project quota              5         50        unlimited
    seat quota                 3         25        unlimited

A billing status of `past_due` overrides every row above to deny.

## Run

    ./run up
    ./run check probes/free_tries_sso.json
    ./run matrix
    ./run test
    ./run down

## Layout

    deploy/           compose file plus cerbos server config
    plans/            resource policies plus derived roles
    plans/verify/     policy tests
    probes/           request payloads used by ./run check

## Notes

Feature and quota rules live in resource policies. The billing lockout is a
principal policy so it wins over every resource decision when a tenant sits
in `past_due`. Adding a plan is a new derived role and a new column in the
feature policy. Adding a quota is a new entry under the `quota` kind and a
new attribute on the principal for its cap.
