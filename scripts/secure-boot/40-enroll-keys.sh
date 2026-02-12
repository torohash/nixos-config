#!/usr/bin/env bash
set -euo pipefail

echo "UEFI 変数へ鍵を登録します（Microsoft 証明書を併用）..."
sudo sbctl enroll-keys --microsoft

echo
echo "ESP 上の署名状態を確認します..."
sudo sbctl verify

echo
echo "完了しました。再起動後に次を実行してください:"
echo "  bash scripts/secure-boot/50-verify-status.sh"
