# ライブ ISO からの `nixos-install` 手順

このリポジトリでビルドした ISO は、起動後に Hyprland が自動起動します。
通常は `scripts/install/README.md` のスクリプト手順を使い、必要に応じてこのドキュメントを参照してください。

> 推奨: 実際の運用では `scripts/install/README.md` の順にスクリプト実行してください。
> このドキュメントは手動操作の参照用です。

## 事前確認

- 重要データのバックアップを取る
- BIOS/UEFI の Secure Boot はインストール中は一時的に OFF にする
  - Secure Boot の有効化はインストール後に実施する（`docs/secure-boot-self-keys.md`）

## 1. ライブ環境でシェルを開く

- 通常は `SUPER` キー（Windows キー相当）+ `Return` で `ghostty` を開く
- 画面がちらついて GUI 操作が難しい場合:
  - `Ctrl + Alt + F2` で TTY に切り替える
  - またはブート時に `systemd.unit=multi-user.target` を一時追加して GUI を起動しない

`sudo` はパスワード認証が必要です。ログイン情報は `local/credentials.nix` で指定した値を使います。

```bash
sudo -i
```

## 2. ネットワーク接続を確認

```bash
ip a
ping -c 3 1.1.1.1
```

Wi-Fi の場合は `nmtui` などで接続します。

## 3. ディスクを確認してマウントする（disko）

> 注意: ここから先は誤るとデータを消します。対象ディスク名を必ず確認してください。

```bash
lsblk -f
```

このリポジトリでは `disko` を使ってレイアウト適用します。
まず `install.env` を作成して `TARGET_DISK` を `by-id` で設定してください。

```bash
cp scripts/install/install.env.example scripts/install/install.env
nano scripts/install/install.env

bash scripts/install/10-check-prerequisites.sh
sudo bash scripts/install/20-partition-and-format.sh
sudo bash scripts/install/30-mount-filesystems.sh
```

## 4. 設定ファイルを生成

```bash
nixos-generate-config --root /mnt
```

生成された設定を編集します。

```bash
nano /mnt/etc/nixos/configuration.nix
```

## 5. `nixos-install` を実行

最小構成でそのまま入れる場合:

```bash
nixos-install
```

flake を使って入れる場合（インストール先のホスト定義がある場合）:

```bash
nixos-install --flake .#<host>
# 例: nixos-install --flake .#my-host
```

別ディレクトリやリモートの flake を使う場合は、次のように URI を指定します。

```bash
# 例: nixos-install --flake github:username/repo#host-name
# 例: nixos-install --flake /path/to/flake#host-name
nixos-install --flake <flake-uri>#<host>
```

## 6. 再起動

```bash
reboot
```

## 参考

- NixOS Manual (Installation): https://nixos.org/manual/nixos/stable/#sec-installation
- NixOS Wiki (Installation Guide): https://wiki.nixos.org/wiki/NixOS_Installation_Guide
