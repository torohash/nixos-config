#!/usr/bin/env bash
set -euo pipefail

flake_file="${1:-./flake.nix}"

echo "[1/4] 起動モードを確認"
if [[ -d /sys/firmware/efi ]]; then
  echo "  OK: UEFI 起動です"
else
  echo "  NG: UEFI 起動ではありません（または /sys/firmware/efi がありません）"
  exit 1
fi

echo "[2/4] bootctl の有無を確認"
if command -v bootctl >/dev/null 2>&1; then
  echo "  OK: bootctl が見つかりました"
else
  echo "  NG: bootctl が見つかりません"
  exit 1
fi

echo "[3/4] 現在のブートローダを確認"
bootctl_status="$(bootctl status || true)"
if grep -q "Product: systemd-boot" <<<"${bootctl_status}"; then
  echo "  OK: systemd-boot を検出しました"
else
  echo "  NG: 'bootctl status' で systemd-boot を検出できませんでした"
  echo "  ヒント: この手順は systemd-boot + lanzaboote を前提とします"
  exit 1
fi

echo "[4/4] flake 内の lanzaboote 記述を確認"
if [[ -f "${flake_file}" ]]; then
  if grep -q "lanzaboote" "${flake_file}"; then
    echo "  OK: '${flake_file}' に lanzaboote の記述があります"
  else
    echo "  WARN: '${flake_file}' に lanzaboote の記述がありません"
    echo "  rebuild 前に input/module の配線を追加してください"
  fi
else
  echo "  WARN: '${flake_file}' が見つからないため、この確認をスキップします"
fi

echo
echo "前提確認が完了しました。"
