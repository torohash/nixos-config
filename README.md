# nixos-config

NixOS minimal を土台にカスタム ISO イメージを作成するための設定リポジトリです。

## ISO イメージのビルド

```bash
nix build .#iso
```

ビルド成果物は `result` シンボリックリンクから参照できます。

## Hyprland の起動

ISO を起動して TTY ログイン後、次のコマンドで Hyprland を起動できます。

```bash
Hyprland
```
