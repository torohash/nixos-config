# 想定ディレクトリ構成

これは、NixOS の minimal installer プロファイルを土台にカスタム ISO を作るための初期構成案です。

```text
.
|-- flake.nix
|-- docs/
|   |-- README.md
|   `-- hyprland-tooling-options.md
|-- local/
|   |-- README.md
|   |-- credentials.example.nix
|   `-- credentials.nix
|-- hosts/
|   `-- iso/
|       `-- minimal/
|           `-- default.nix
`-- modules/
    `-- iso/
        `-- minimal/
            |-- assertions.nix
            |-- auth-session.nix
            |-- default.nix
            |-- desktop-hyprland.nix
            `-- packages.nix
```

補足:

- `hosts/iso`: ISO バリアントごとのホスト定義エントリポイント。
- `local`: クローン後に値を変更するローカル設定ファイル群。
- `modules/iso`: ISO バリアントごとの実装レイヤー。
- `modules/iso/minimal/assertions.nix`: `local/credentials.nix` の必須値バリデーション。
- `modules/iso/minimal/auth-session.nix`: ユーザー定義、greetd、自動起動、sudo の認証動作。
- `modules/iso/minimal/desktop-hyprland.nix`: Hyprland 有効化設定。
- `modules/iso/minimal/packages.nix`: minimal ISO 用の UI ツールセット定義。
