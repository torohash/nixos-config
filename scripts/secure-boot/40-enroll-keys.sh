#!/usr/bin/env bash
set -euo pipefail

sudo sbctl enroll-keys --microsoft
sudo sbctl verify
