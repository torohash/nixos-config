# ローカル設定ディレクトリ

クローン後に利用者ごとで変更する値は、このディレクトリに集約します。

## credentials.nix

`default_username` と `default_password` を定義します。

初回は `credentials.example.nix` をコピーして作成します。

```bash
cp local/credentials.example.nix local/credentials.nix
```

- この値は ISO のユーザー作成、greetd の自動ログインユーザー、sudo パスワード認証で共通利用されます。
- 空文字や `CHANGE_ME` のままビルドすると、NixOS モジュールの assertion で評価エラーになります。
- 公開運用する場合は、必ず値を変更してください。
