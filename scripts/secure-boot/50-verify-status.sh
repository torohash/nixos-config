#!/usr/bin/env bash
set -euo pipefail

echo "bootctl status の出力:"
bootctl status

echo
echo "sbctl status の出力:"
sudo sbctl status

echo
echo "sbctl verify の出力:"
sudo sbctl verify || true

echo
echo "bootctl に 'Secure Boot: enabled (user)' と表示されれば有効化完了です。"
