# ドキュメント

このディレクトリには、NixOS ISO プロジェクトの設計メモや実装計画を配置します。

実際の実行手順は `scripts/*/README.md` を優先してください。

- `directory-structure.md`: 今後の実装フェーズで想定しているリポジトリ構成。
- `hyprland-tooling-options.md`: ghostty/hyprpanel/fuzzel の位置づけと代替候補の整理。
- `nixos-install.md`: ライブ ISO 起動後に `nixos-install` でインストールする手順。
- `secure-boot-self-keys.md`: 自前鍵方式で Secure Boot を有効化する手順メモ。

関連スクリプト:

- `../scripts/install/README.md`: インストール手順を上から順に実行するための runbook。
- `../scripts/secure-boot/README.md`: Secure Boot 実行スクリプトの使い方。
