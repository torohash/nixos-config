#!/usr/bin/env bash
set -euo pipefail

bootctl status
sudo sbctl status
sudo sbctl verify
