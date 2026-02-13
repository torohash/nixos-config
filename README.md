# nixos-config

NixOS minimal を土台にカスタム ISO イメージを作成するための設定リポジトリです。

## 全体フロー

このリポジトリで日常的に使う手順は、次の 3 つに集約しています。

1. ISO を作る: この README の「ISO イメージのビルド」
2. ISO でインストールする: `scripts/install/README.md`
3. インストール後に Secure Boot を有効化する: `scripts/secure-boot/README.md`

手順を個別メモから辿らなくても、上記 3 本を順に見れば進められる構成にしています。

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

初期状態で次のキーバインドを配布しています。

- `SUPER + Return`: `ghostty` を起動
- `SUPER + D`: `fuzzel` を起動
- `SUPER + Q`: アクティブウィンドウを閉じる
- `SUPER + Shift + M`: Hyprland を終了

Hyprland は `--config /etc/xdg/hypr/hyprland.conf` で起動するため、自動生成設定ではなく配布設定を使用します。

## Graphics ベース設定

このリポジトリでは `modules/system/graphics/base.nix` で、次の共通設定を入れています。

- `services.xserver.videoDrivers = [ "modesetting" ]`
- `hardware.graphics.enable = true`

Intel のメディアアクセラレーションを有効化したい場合は、ホスト側で次を設定してください。

```nix
custom.graphics.intelMedia.enable = true;
```

ログアウト後に表示される `greetd` ログイン画面から入り直す場合は、次の値を使います。

- ユーザー名: `local/credentials.nix` の `default_username`
- パスワード: `local/credentials.nix` の `default_password`

## ISO 起動後のインストール

このリポジトリの ISO はライブ環境を提供します。
インストールはスクリプトで上から順に実行できます。

- 推奨手順: `scripts/install/README.md`
- 手動手順（参照用）: `docs/nixos-install.md`

## Secure Boot (自前鍵方式)

このリポジトリは ISO ビルド用途です。Secure Boot の有効化は、通常はインストール後 OS 側で行います。

- 手順メモ: `docs/secure-boot-self-keys.md`
- 実行手順（推奨）: `scripts/secure-boot/README.md`
- 再利用モジュール例: `modules/system/secure-boot/lanzaboote-self-keys.nix`

## ドキュメント案内

- `docs/README.md`: ドキュメント索引
- `docs/nixos-install.md`: 手動インストールの詳細
- `docs/secure-boot-self-keys.md`: Secure Boot の設計メモと背景
