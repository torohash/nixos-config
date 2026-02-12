# 想定ディレクトリ構成

これは、NixOS の minimal installer プロファイルを土台にカスタム ISO を作るための初期構成案です。

```text
.
|-- flake.nix
|-- docs/
|   |-- README.md
|   `-- directory-structure.md
|-- hosts/
|   `-- iso/
|       `-- default.nix
|-- modules/
|   |-- base/
|   |   `-- default.nix
|   |-- iso/
|   |   `-- default.nix
|   `-- profiles/
|       `-- minimal.nix
|-- overlays/
|   `-- default.nix
`-- packages/
    `-- default.nix
```

補足:

- `hosts/iso`: ISO ビルドターゲット向けのホスト定義エントリポイント。
- `modules/base`: ターゲット間で再利用する共通システム設定。
- `modules/iso`: ISO 固有の設定（インストーラ挙動、イメージメタデータなど）。
- `modules/profiles/minimal.nix`: NixOS minimal installer に積み重ねるプロジェクト用プロファイル。
- `overlays` と `packages`: 必要に応じた独自パッケージ定義。
