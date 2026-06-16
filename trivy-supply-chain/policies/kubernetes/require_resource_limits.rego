# METADATA
# title: Containers must declare CPU and memory limits
# description: Missing limits let a single workload starve neighbors on the node.
# scope: package
# schemas:
#   - input: schema["kubernetes"]
# custom:
#   id: POC-K8S-002
#   severity: MEDIUM
package custom.kubernetes.resources

import data.lib.kubernetes

deny[res] {
  container := kubernetes.containers[_]
  not container.resources.limits.cpu
  res := sprintf("container %q has no cpu limit", [container.name])
}

deny[res] {
  container := kubernetes.containers[_]
  not container.resources.limits.memory
  res := sprintf("container %q has no memory limit", [container.name])
}
