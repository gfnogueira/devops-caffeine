import json
import subprocess
from datetime import datetime, timedelta, timezone
from pathlib import Path

EVENT_LOG_PATH = "/var/log/falco/falco-events.log"


def read_recent_events(seconds: int = 30, falco_container: str = "falco-runtime") -> list[dict]:
    """Read JSON-line events from the falco container event log."""
    cutoff = datetime.now(timezone.utc) - timedelta(seconds=seconds)
    proc = subprocess.run(
        ["docker", "exec", falco_container, "cat", EVENT_LOG_PATH],
        capture_output=True,
        text=True,
        check=False,
    )
    if proc.returncode != 0:
        return []

    events = []
    for line in proc.stdout.splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        time_str = event.get("time")
        if time_str:
            try:
                event_time = datetime.fromisoformat(time_str.replace("Z", "+00:00"))
            except ValueError:
                event_time = None
            if event_time and event_time < cutoff:
                continue
        events.append(event)
    return events


def write_capture(events: list[dict], path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as fh:
        for event in events:
            fh.write(json.dumps(event) + "\n")
