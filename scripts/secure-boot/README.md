# Secure Boot 補助スクリプト

これらのスクリプトは、ISO ビルド時ではなく、インストール後の NixOS で使います。

実行順序:

1. `bash scripts/secure-boot/10-check-prerequisites.sh`
2. `sudo nixos-rebuild switch --flake .#<FLAKE_CONFIG_NAME>`
3. `bash scripts/secure-boot/20-create-keys.sh`
4. `bash scripts/secure-boot/30-reboot-to-firmware.sh`
5. BIOS/UEFI で手動操作: Setup Mode に切り替える
6. `bash scripts/secure-boot/40-enroll-keys.sh`
7. `bash scripts/secure-boot/50-verify-status.sh`

`<FLAKE_CONFIG_NAME>` は `nixosConfigurations.<name>` の `<name>` を指します。
このリポジトリでは `iso` です。

補足:

- `30-reboot-to-firmware.sh` は再起動前に確認を行います。
- `40-enroll-keys.sh` は既定で `sbctl enroll-keys --microsoft` を使います。
- ファームウェアの仕様に応じて、必要ならコマンドを調整してください。
