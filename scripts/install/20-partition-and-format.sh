#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
source "${SCRIPT_DIR}/install.env"

DISKO_CONFIG_PATH="${REPO_ROOT}/${DISKO_CONFIG}"

if [[ ! -f "${DISKO_CONFIG_PATH}" ]]; then
  echo "disko config not found: ${DISKO_CONFIG_PATH}" >&2
  exit 1
fi

umount -R /mnt || true

echo "WARNING: This will destroy data on ${TARGET_DISK}."
read -r -p "Type YES to continue: " answer
if [[ "${answer}" != "YES" ]]; then
  echo "Aborted."
  exit 1
fi

nix --experimental-features "nix-command flakes" \
  run "${REPO_ROOT}#disko" -- \
  --mode "${DISKO_MODE}" \
  --argstr disk "${TARGET_DISK}" \
  "${DISKO_CONFIG_PATH}"

findmnt -R /mnt
