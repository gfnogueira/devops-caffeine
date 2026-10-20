# keyless cosign

This lab uses a locally generated key pair because `kind` runs offline and
Sigstore's keyless flow would need outbound Fulcio and Rekor calls.

Keyless looks like:

    cosign sign <ref>
    # browser opens, OIDC provider (GitHub, Google) returns a token
    # Fulcio issues a short lived cert bound to the OIDC identity
    # the signature plus the cert is written back to the registry
    # Rekor records the transparency log entry

Verification then matches on the OIDC identity, not a public key:

    cosign verify <ref> \
      --certificate-identity "https://github.com/me/repo/.github/workflows/release.yml@refs/heads/main" \
      --certificate-oidc-issuer "https://token.actions.githubusercontent.com"

For CI pipelines keyless is the default. For an airgapped lab, key pairs
with `--tlog-upload=false` and `--insecure-ignore-tlog` is the pragmatic
shortcut.
