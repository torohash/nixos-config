#!/usr/bin/env bash
set -euo pipefail

echo "Verify mounts created by disko"
findmnt -R /mnt
lsblk -f
