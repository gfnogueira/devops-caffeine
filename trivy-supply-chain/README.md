# trivy-supply-chain

Supply-chain hygiene playbook driven by Trivy. Targets in `targets/` are kept
intentionally vulnerable; scans land in `reports/`.

## Run

```bash
make scan-images
```

Outputs are SARIF (for code scanning UIs) and table (for terminals).

## Layout

```
targets/      vulnerable artifacts to scan (do not deploy)
runbook/      scan runners
policies/     custom Rego policies for IaC and image checks
.trivyignore  triaged CVEs with owner and expiry
```
