from dataclasses import dataclass


@dataclass(frozen=True)
class Expectation:
    simulation: str
    rule: str
    min_priority: str = "Notice"


EXPECTATIONS: tuple[Expectation, ...] = (
    Expectation("shell_in_container.sh",      "Interactive shell spawned in container"),
    Expectation("privileged_container.sh",    "Privileged container started"),
    Expectation("sensitive_mount.sh",         "Container mounted sensitive host path"),
    Expectation("sensitive_file_read.sh",     "Read of sensitive secret file",         "Critical"),
    Expectation("crypto_miner_pattern.sh",    "Known crypto miner binary executed",    "Critical"),
    Expectation("reverse_shell.sh",           "Reverse shell command pattern detected", "Critical"),
    Expectation("persistence_attempt.sh",     "Write to system persistence path"),
    Expectation("ssh_authorized_keys.sh",     "SSH authorized_keys modified",          "Critical"),
)


def find_match(events: list[dict], rule: str) -> dict | None:
    for event in events:
        if event.get("rule") == rule:
            return event
    return None
