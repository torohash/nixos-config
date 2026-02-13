#!/usr/bin/env bash
set -euo pipefail

sudo sbctl status
sudo sbctl create-keys
sudo sbctl status
