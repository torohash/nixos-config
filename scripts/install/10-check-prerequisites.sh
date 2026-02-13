#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/install.env"

test -d /sys/firmware/efi
command -v nix >/dev/null

if [[ "${TARGET_DISK}" == "/dev/disk/by-id/CHANGEME" ]]; then
  echo "TARGET_DISK is still CHANGEME. Update scripts/install/install.env first." >&2
  exit 1
fi

lsblk -f
findmnt /mnt || true
