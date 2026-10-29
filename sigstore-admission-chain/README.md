# sigstore-admission-chain

A supply chain in miniature. An image is built, pushed to a local registry,
signed with Cosign, attested with the Trivy SBOM, and then only let into
the cluster when `policy-controller` can verify the signature and the
attestation at admission time.

## The chain

    docker build          >>   registry.local:5000/<app>:0.1.0
    cosign sign                 attaches .sig to the image digest
    trivy image + cosign attest attaches a CycloneDX predicate
    kubectl apply          >>   policy-controller webhook intercepts
                                checks signature against cosign.pub
                                checks CycloneDX attestation presence
                                admits or rejects with a reason

Three ClusterImagePolicies cover the rollout. `warn-first` posts warnings
without blocking, `require-signature` blocks unsigned, `require-sbom-attest`
goes further and insists the signature carries a CycloneDX predicate.

See `notes/keyless.md` for why the lab uses a key pair instead of the
public Sigstore keyless flow.

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
