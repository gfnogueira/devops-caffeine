# sigstore-admission-chain

A supply chain in miniature. An image is built, pushed to a local registry,
signed with Cosign, attested with the Trivy SBOM, and then only let into
the cluster when `policy-controller` can verify the signature and the
attestation at admission time.

## Run

    mise run up
    mise run build
    mise run sign
    mise run verify
    mise run attest
    mise run warn
    mise run enforce
    mise run logs
    mise run down
