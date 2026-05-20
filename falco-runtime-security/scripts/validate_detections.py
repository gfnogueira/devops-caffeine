import os
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

from lib.event_collector import read_recent_events, write_capture
from lib.detection_matchers import EXPECTATIONS, find_match

SIMULATE_DIR = Path(__file__).resolve().parent / "simulate"
CAPTURE_DIR = Path(__file__).resolve().parent.parent / "events"
TIMEOUT_SECONDS = int(os.getenv("VALIDATION_TIMEOUT_SECONDS", "30"))


def run_simulation(simulation: str) -> int:
    script = SIMULATE_DIR / simulation
    return subprocess.run(
        ["bash", str(script)],
        check=False,
        capture_output=True,
        text=True,
    ).returncode


def wait_for_rule(rule: str, window: int) -> dict | None:
    deadline = time.time() + window
    while time.time() < deadline:
        events = read_recent_events(seconds=window + 5)
        match = find_match(events, rule)
        if match:
            return match
        time.sleep(1)
    return None


def main() -> int:
    print(f"==> Detection validation started at {datetime.now(timezone.utc).isoformat()}")
    print(f"    timeout per simulation: {TIMEOUT_SECONDS}s")
    print()

    failures: list[str] = []
    captured: list[dict] = []

    for exp in EXPECTATIONS:
        print(f"[{exp.simulation}] -> expect rule '{exp.rule}'")
        rc = run_simulation(exp.simulation)
        if rc != 0:
            print(f"  simulation exited with code {rc} (continuing)")

        match = wait_for_rule(exp.rule, TIMEOUT_SECONDS)
        if match is None:
            print("  MISS: no matching event captured\n")
            failures.append(exp.rule)
            continue

        captured.append(match)
        print(f"  HIT: priority={match.get('priority')} time={match.get('time')}")
        print()

    capture_path = CAPTURE_DIR / f"validation_{int(time.time())}.jsonl"
    write_capture(captured, capture_path)
    print(f"Captured {len(captured)} events to {capture_path}")

    if failures:
        print(f"\nFAILED: {len(failures)} rule(s) did not fire:")
        for rule in failures:
            print(f"  - {rule}")
        return 1

    print(f"\nPASSED: all {len(EXPECTATIONS)} detections fired as expected")
    return 0


if __name__ == "__main__":
    sys.exit(main())
