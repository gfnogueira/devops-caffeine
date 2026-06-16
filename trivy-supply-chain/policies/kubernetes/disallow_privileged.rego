# METADATA
# title: Containers must not run privileged
# description: Privileged pods bypass container isolation; only kernel modules and
#   storage drivers have a legitimate reason and they should live in their own ns.
# scope: package
# schemas:
#   - input: schema["kubernetes"]
# custom:
#   id: POC-K8S-001
#   severity: HIGH
package custom.kubernetes.privileged

import data.lib.kubernetes

deny[res] {
  container := kubernetes.containers[_]
  container.securityContext.privileged == true
  res := sprintf("container %q runs privileged", [container.name])
}
