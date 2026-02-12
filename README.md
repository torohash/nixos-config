# nixos-config

NixOS minimal を土台にカスタム ISO イメージを作成するための設定リポジトリです。

## ISO イメージのビルド

```bash
nix build .#iso
```

ビルド後の成果物配置は次のとおりです。

- `./result`: `/nix/store/...-nixos-minimal-custom.iso` へのシンボリックリンク
- `./result/iso/nixos-minimal-custom.iso`: 実際の ISO ファイル
- `./result/nix-support/`: ビルドメタデータ（`hydra-build-products` など）

## ローカル設定

クローン後に変更する値は `local/` 配下に集約しています。

- `local/credentials.example.nix`: テンプレート
- `local/credentials.nix`: 実際の値を定義（`.gitignore` 対象）
- `modules/iso/minimal/default.nix` は `local/credentials.nix` を読み込み、ユーザー作成・greetd 自動起動・sudo 認証に共通利用

初回は次のコマンドでテンプレートをコピーしてください。

```bash
cp local/credentials.example.nix local/credentials.nix
```

このリポジトリを公開運用する場合は、`local/credentials.nix` の値を必ず変更してください。

## Hyprland の起動

ISO 起動時は `greetd` の設定により、`local/credentials.nix` の `default_username` で Hyprland を自動起動します。

ログアウト後に表示される `greetd` ログイン画面から入り直す場合は、次の値を使います。

- ユーザー名: `local/credentials.nix` の `default_username`
- パスワード: `local/credentials.nix` の `default_password`
