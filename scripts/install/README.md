# NixOS インストール補助スクリプト

ライブ ISO 起動後、必要コマンドだけを番号順に実行するためのスクリプト群です。

対象レイアウト:

- `/` : btrfs subvolume (`root00`)
- `/home` : btrfs subvolume (`home00`)
- `/boot` : ext4
- `/boot/efi` : vfat
- swap: zram（ディスク swap は作成しない）

現在のレイアウト適用は `disko` で実行します。

## 0. 事前準備

```bash
cp scripts/install/install.env.example scripts/install/install.env
```

`scripts/install/install.env` を開いて最低限次を設定してください。

- `TARGET_DISK` : 破壊対象ディスク（推奨: `/dev/disk/by-id/...`）
- `DISKO_CONFIG` : 利用する disko 定義ファイル
- `DISKO_MODE` : `destroy,format,mount` などの実行モード
- `FLAKE_URI`, `FLAKE_HOST` : flake で入れる場合のみ設定（未設定なら `nixos-install`）

例:

```bash
TARGET_DISK="/dev/disk/by-id/nvme-SAMSUNG_MZVL21T0HCLR-00B00_S63ANX0W123456"
DISKO_CONFIG="disko/single-disk-btrfs.nix"
DISKO_MODE="destroy,format,mount"
FLAKE_URI="."
FLAKE_HOST="my-host"
```

## 実行順序

1. `bash scripts/install/10-check-prerequisites.sh`
2. `sudo bash scripts/install/20-partition-and-format.sh`
3. `sudo bash scripts/install/30-mount-filesystems.sh`
4. `sudo bash scripts/install/40-generate-config.sh`
5. `sudo bash scripts/install/50-install-nixos.sh`
6. `sudo bash scripts/install/60-reboot.sh`

## install.env の主な変数

- `TARGET_DISK`: 対象ディスク
- `DISKO_CONFIG`: disko のレイアウト定義
- `DISKO_MODE`: disko 実行モード
- `FLAKE_URI`, `FLAKE_HOST`: `nixos-install --flake` の install 先（両方空なら通常の `nixos-install`）

## 注意

- `20-partition-and-format.sh` は disko で対象ディスクを初期化します。
- `TARGET_DISK` は `by-id` 指定を推奨します。
- `50-install-nixos.sh` は、`FLAKE_URI/FLAKE_HOST` が両方空なら `nixos-install` を実行します。
- `50-install-nixos.sh` は `FLAKE_HOST=iso` を拒否します（ISO ではなくインストール先ホスト定義を使うため）。
- 実行前に `lsblk -f` で対象ディスクを必ず確認してください。
- 既存の手動手順は `docs/nixos-install.md` を参照してください。
