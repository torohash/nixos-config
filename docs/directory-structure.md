# 想定ディレクトリ構成

これは、NixOS の minimal installer プロファイルを土台にカスタム ISO を作るための初期構成案です。

```text
.
|-- flake.nix
|-- docs/
|   |-- README.md
|   |-- secure-boot-self-keys.md
|   `-- hyprland-tooling-options.md
|-- local/
|   |-- credentials.example.nix
|   `-- credentials.nix
|-- hosts/
|   `-- iso/
|       `-- minimal/
|           `-- default.nix
|-- scripts/
|   `-- secure-boot/
|       |-- README.md
|       |-- 10-check-prerequisites.sh
|       |-- 20-create-keys.sh
|       |-- 30-reboot-to-firmware.sh
|       |-- 40-enroll-keys.sh
|       `-- 50-verify-status.sh
`-- modules/
    |-- iso/
    |   `-- minimal/
    |       |-- assertions.nix
    |       |-- auth-session.nix
    |       |-- default.nix
    |       |-- desktop-hyprland.nix
    |       |-- hyprland-config.nix
    |       `-- packages.nix
    `-- system/
        |-- graphics/
        |   |-- base.nix
        |   |-- default.nix
        |   `-- intel-media.nix
        `-- secure-boot/
            `-- lanzaboote-self-keys.nix
```

補足:

- `hosts/iso`: ISO バリアントごとのホスト定義エントリポイント。
- `local/credentials.example.nix`: credentials 入力のテンプレート。
- `local/credentials.nix`: 利用者ごとの実値（`.gitignore` 対象）。
- `modules/iso`: ISO バリアントごとの実装レイヤー。
- `modules/iso/minimal/assertions.nix`: `local/credentials.nix` の必須値バリデーション。
- `modules/iso/minimal/auth-session.nix`: ユーザー定義、greetd、自動起動、sudo の認証動作。
- `modules/iso/minimal/desktop-hyprland.nix`: Hyprland 有効化設定。
- `modules/iso/minimal/hyprland-config.nix`: `/etc/xdg/hypr/hyprland.conf` と初期キーバインド配布。
- `modules/iso/minimal/packages.nix`: minimal ISO 用の UI ツールセット定義。
- `modules/system/graphics/base.nix`: GPU の共通ベース設定（`modesetting` と `hardware.graphics`）。
- `modules/system/graphics/intel-media.nix`: Intel のメディアアクセラレーションをオプションで有効化するモジュール。
- `modules/system/graphics/default.nix`: graphics 系モジュールの集約 import。
- `modules/system/secure-boot/lanzaboote-self-keys.nix`: インストール後 OS 向けの Secure Boot 有効化モジュール例。
- `scripts/secure-boot/*.sh`: インストール後 OS 側で Secure Boot 手順を段階実行する補助スクリプト。
