#!/usr/bin/env bash
set -euo pipefail

echo "現在の sbctl 状態を確認します..."
sudo sbctl status || true

if sudo test -d /var/lib/sbctl/keys; then
  echo
  echo "/var/lib/sbctl/keys に既存キーがあります"
  echo "キー作成をスキップします。ローテーション/リセット時のみ手動削除してください。"
  exit 0
fi

echo
echo "Secure Boot キーを作成します..."
sudo sbctl create-keys

echo
echo "現在の sbctl 状態:"
sudo sbctl status
