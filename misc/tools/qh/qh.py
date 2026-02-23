#!/usr/bin/env python3
"""
hist.py - Quickly pick and run your most-used bash commands.
"""

import os
import subprocess
from collections import Counter

HISTORY_FILE = os.path.expanduser("~/.bash_history")
TOP_N = 8
HISTORY_DEPTH = 100  # Most recent commands

exclude_pattern = [
    "nvim", "exit", "ls", "cd", "git"
]


def starts_with_excluded(cmd):
    return any([cmd.startswith(pattern) for pattern in exclude_pattern])


def load_history():
    if not os.path.exists(HISTORY_FILE):
        print(f"No bash history found at {HISTORY_FILE}")
        return []
    with open(HISTORY_FILE, "r", errors="ignore") as f:
        lines = [line.strip() for line in f if line.strip()
                 and not line.startswith("#")]
    if len(lines) > HISTORY_DEPTH:
        return lines[-HISTORY_DEPTH:]
    else:
        return lines


def get_top_commands(history, n=TOP_N):
    history = [
        item for item in history if not starts_with_excluded(item)]
    counts = Counter(history)
    return counts.most_common(n)


def main():
    history = load_history()
    if not history:
        return

    top = get_top_commands(history)

    print("\n  Most used commands:\n")
    for i, (cmd, count) in enumerate(top, 1):
        print(f"  [{i}]  {cmd}  \033[90m(×{count})\033[0m")
    print()

    try:
        choice = input("  Run #: ").strip()
    except (KeyboardInterrupt, EOFError):
        print()
        return

    if not choice.isdigit():
        print("  No command run.")
        return

    idx = int(choice) - 1
    if not (0 <= idx < len(top)):
        print("  Invalid selection.")
        return

    cmd = top[idx][0]
    print(f"\n  $ {cmd}\n")
    subprocess.run(cmd, shell=True)


if __name__ == "__main__":
    main()
