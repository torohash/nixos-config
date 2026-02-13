#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/install.env"

if [[ -n "${FLAKE_URI}" && -z "${FLAKE_HOST}" ]]; then
  echo "FLAKE_URI is set but FLAKE_HOST is empty." >&2
  exit 1
fi

if [[ -z "${FLAKE_URI}" && -n "${FLAKE_HOST}" ]]; then
  echo "FLAKE_HOST is set but FLAKE_URI is empty." >&2
  exit 1
fi

if [[ -z "${FLAKE_URI}" && -z "${FLAKE_HOST}" ]]; then
  nixos-install
  exit 0
fi

if [[ "${FLAKE_HOST}" == "iso" ]]; then
  echo "FLAKE_HOST=iso is for live ISO build, not install target. Use an installed host config." >&2
  exit 1
fi

nixos-install --flake "${FLAKE_URI}#${FLAKE_HOST}"
