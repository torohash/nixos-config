# nixos-config

NixOS minimal を土台にカスタム ISO イメージを作成するための設定リポジトリです。

## ISO イメージのビルド

```bash
nix build .#iso
```

ビルド成果物は `result` シンボリックリンクから参照できます。
