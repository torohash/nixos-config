# Secure Boot (自前鍵方式) 導入メモ

このリポジトリは ISO ビルド用途です。Secure Boot の自前鍵設定は、
"この ISO でインストールした後の常用 NixOS" 側で行います。

## 何を切り分けるか

- ISO ビルド: このリポジトリの `flake.nix` と `hosts/iso/*`
- インストール後の Secure Boot 設定: `modules/system/secure-boot/*` と `scripts/secure-boot/*`

上記を分けているので、ISO ビルド自体には Secure Boot 設定が混ざりません。

## 全体像

1. このリポジトリで通常どおり ISO を作る
2. Secure Boot を一時的に OFF で ISO を起動し、NixOS をインストール
3. インストール済み OS 側で Lanzaboote + sbctl を有効化
4. 鍵を作成して UEFI に登録
5. Secure Boot を ON に戻して確認

## 0. まず前提確認（インストール済み OS 側）

### UEFI 起動か

```bash
test -d /sys/firmware/efi && echo "UEFI boot" || echo "Legacy BIOS boot"
```

`UEFI boot` と出れば OK です。

### ブートローダが systemd-boot か

```bash
bootctl status
```

`Current Boot Loader` セクション内に `Product: systemd-boot` があれば OK です。

## 1. 「lanzaboote の input を追加」とは

flake の `inputs` に `lanzaboote` を追加し、`outputs` の引数で受け取り、
ホスト `modules` に `lanzaboote.nixosModules.lanzaboote` を入れる、という意味です。

最小例:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lanzaboote, ... }: {
    nixosConfigurations.<HOSTNAME> = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        lanzaboote.nixosModules.lanzaboote
        ./modules/system/secure-boot/lanzaboote-self-keys.nix
      ];
    };
  };
}
```

## 2. このリポジトリで用意しているモジュール

- `modules/system/secure-boot/lanzaboote-self-keys.nix`

このモジュールは次を設定します。

- `pkgs.sbctl` をインストール
- `boot.loader.systemd-boot.enable = lib.mkForce false`
- `boot.lanzaboote.enable = true`
- `boot.lanzaboote.pkiBundle = "/var/lib/sbctl"`

## 3. .sh スクリプトでの実行手順

このリポジトリでは、コマンドを段階的に実行するために
`scripts/secure-boot/` にスクリプトを用意しています。

実行順序:

1. `bash scripts/secure-boot/10-check-prerequisites.sh`
2. `sudo nixos-rebuild switch --flake .#<FLAKE_CONFIG_NAME>`
3. `bash scripts/secure-boot/20-create-keys.sh`
4. `bash scripts/secure-boot/30-reboot-to-firmware.sh`
5. BIOS/UEFI で Setup Mode に変更（手動）
6. `bash scripts/secure-boot/40-enroll-keys.sh`
7. `bash scripts/secure-boot/50-verify-status.sh`

`<FLAKE_CONFIG_NAME>` は `nixosConfigurations.<name>` の `<name>` です。
このリポジトリでは `iso` です（`nix flake show` で確認可能）。

## 4. BIOS/UEFI で手動操作が必要な箇所

`30-reboot-to-firmware.sh` 実行後、BIOS/UEFI 画面で Secure Boot の鍵管理に入り、
Setup Mode にします。機種ごとに名称が違います。

- 例: "Reset to Setup Mode"
- 例: PK を削除して Setup Mode にする

`dbx` の全消去は避けてください。

## 5. 更新時運用

- `nixos-rebuild` 後に `sudo sbctl verify` を実行
- 追加署名が必要な構成では `sudo sbctl sign-all` を実行

## 6. 名前について

- 鍵階層名は UEFI 仕様上 `PK` / `KEK` / `db`
- `sbctl create-keys` で `Owner UUID` が自動生成
- UEFI ブートメニュー表示名（`NixOS`, `Linux Boot Manager` など）は
  鍵名とは別概念
