#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'
これからファームウェア設定画面に再起動します。

BIOS/UEFI で次の手動操作を行ってください:
  1) Secure Boot の鍵管理画面を開く
  2) Setup Mode に切り替える
     （多くの機種では PK 削除 / "Reset to Setup Mode"）
  3) 保存して NixOS へ再起動

NixOS に戻ったら次を実行:
  bash scripts/secure-boot/40-enroll-keys.sh
EOF

read -r -p "今すぐファームウェア設定画面へ再起動しますか？ [y/N]: " answer
case "${answer}" in
  y|Y|yes|YES)
    sudo systemctl reboot --firmware-setup
    ;;
  *)
    echo "キャンセルしました。"
    ;;
esac
