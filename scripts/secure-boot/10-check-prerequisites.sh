#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

test -d /sys/firmware/efi
bootctl status
grep -n "lanzaboote" "${SCRIPT_DIR}/../../flake.nix"
