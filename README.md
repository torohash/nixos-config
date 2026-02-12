# nixos-config

NixOS minimal を土台にカスタム ISO イメージを作成するための設定リポジトリです。

## ISO イメージのビルド

```bash
nix build .#iso --override-input credentials "path:./local/credentials.nix"
```

ビルド後の成果物配置は次のとおりです。

- `./result`: `/nix/store/...-nixos-minimal-custom.iso` へのシンボリックリンク
- `./result/iso/nixos-minimal-custom.iso`: 実際の ISO ファイル
- `./result/nix-support/`: ビルドメタデータ（`hydra-build-products` など）

## credentials 入力ファイル

認証情報は `credentials` flake input として注入します。

- `local/credentials.example.nix`: テンプレート（コミット対象）
- `local/credentials.nix`: 実際の値（`.gitignore` 対象）
- `modules/iso/minimal/*` はこの入力値を使って、ユーザー作成・greetd 自動起動・sudo 認証を共通設定

初回はテンプレートをコピーして値を変更してください。

```bash
cp local/credentials.example.nix local/credentials.nix
```

値を差し替えずに `nix build .#iso` した場合は assertion でエラーになります。

## Hyprland の起動

ISO 起動時は `greetd` の設定により、`local/credentials.nix` の `default_username` で Hyprland を自動起動します。

ログアウト後に表示される `greetd` ログイン画面から入り直す場合は、次の値を使います。

- ユーザー名: `local/credentials.nix` の `default_username`
- パスワード: `local/credentials.nix` の `default_password`
