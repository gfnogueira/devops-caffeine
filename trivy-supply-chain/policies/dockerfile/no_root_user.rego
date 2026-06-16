# METADATA
# title: Image must declare a non-root USER
# description: Trivy already flags missing USER but our policy makes it blocking.
# scope: package
# schemas:
#   - input: schema["dockerfile"]
# custom:
#   id: POC-DOCKER-001
#   severity: HIGH
package custom.dockerfile.user

deny[res] {
  some i
  stage := input.Stages[i]
  not has_user(stage)
  res := sprintf("stage %q does not declare a USER", [stage.Name])
}

has_user(stage) {
  some j
  cmd := stage.Commands[j]
  cmd.Cmd == "user"
}
