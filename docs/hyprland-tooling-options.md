# Hyprland 周辺ツールの選定メモ

この資料は、現在導入している `ghostty` / `hyprpanel` / `fuzzel` が「何者か」を整理し、置き換え候補を比較するためのメモです。

## 前提

- 対象は Hyprland を使う Wayland 環境。
- `ghostty` / `hyprpanel` / `fuzzel` は必須ではなく、用途に応じて差し替え可能。
- ここでは「初期導入しやすさ」と「運用時の拡張しやすさ」を重視して比較する。

## 現在の構成と役割

| カテゴリ | 現在のツール | 何者か | 現時点での採用理由 |
|---|---|---|---|
| ターミナル | `ghostty` | GPU レンダリング対応のモダンなターミナル | 表示品質と操作感が良く、Wayland 利用時の体験が良い |
| ステータスバー | `hyprpanel` | Hyprland 向けの統合パネル | Hyprland 向け機能がまとまっており、見た目を作り込みやすい |
| ランチャー | `fuzzel` | Wayland 向けの軽量ランチャー | 起動が速く、最小構成でも扱いやすい |

## 各ツールの説明と一般的な代替候補

## 1) ghostty（ターミナル）

- 概要: GPU を活用するモダンなターミナル。表示品質と操作感を重視しやすい。
- 向いているケース: 見た目・操作感と性能を両立したい。

主な代替候補:

- `kitty`: 定番の高機能ターミナル。設定資産が多く運用しやすい。
- `alacritty`: 高速でシンプル。余計な機能を抑えたい場合に向く。
- `foot`: Wayland ネイティブで軽量。最小構成志向と相性が良い。
- `wezterm`: 高機能で拡張しやすい。設定自由度重視向け。

## 2) hyprpanel（ステータスバー）

- 概要: Hyprland 環境向けの統合パネル。バー周りを一体的に構成しやすい。
- 向いているケース: 見た目の統一感を重視したい、Hyprland 向け機能をまとめて使いたい。

主な代替候補:

- `waybar`: Wayland の定番。安定性と情報量を重視する場合の第一候補。
- `eww`: 汎用ウィジェット寄り。自由度は高いが設計コストも高い。
- `ags`（Aylur's GTK Shell）: スクリプトで UI を組む方式。柔軟性重視向け。
- `yambar`: 軽量志向のバー。機能より省リソースを優先したい場合に向く。

## 3) fuzzel（ランチャー）

- 概要: Wayland 用の軽量ランチャー。キーボード中心で高速に起動できる。
- 向いているケース: 最小構成で軽さと速度を優先したい。

主な代替候補:

- `rofi-wayland`: rofi 系 UI を Wayland で使いたい場合の定番候補。
- `wofi`: dmenu 的な分かりやすさを重視したい場合に向く。
- `bemenu`: dmenu に近い操作感。キーボード中心の運用と相性が良い。
- `tofi`: 最小・高速志向。極力シンプルなランチャーを求める場合に向く。

## 選定の判断軸（実務向け）

- 最初に決めるべきこと: 「見た目の自由度優先」か「導入と保守の軽さ優先」か。
- 開発/検証 ISO の初期値としては、まずは定番の組み合わせを使い、後で差し替える方が安全。
- 差し替える際はカテゴリを 1:1 で置き換える（ターミナル/バー/ランチャー）と混乱しにくい。

## このリポジトリでの扱い

- 現在は `modules/iso/minimal/packages.nix` で `ghostty` / `fuzzel` / `hyprpanel` を管理している。
- `modules/iso/minimal/default.nix` は ISO 固有モジュールを import する集約点で、`environment.systemPackages` は `modules/iso/minimal/packages.nix` で定義している。
- GPU の共通ベース設定は `modules/system/graphics/base.nix` で管理しており、`modesetting` + `hardware.graphics.enable` をデフォルト化している。
- Intel のメディアアクセラレーションは `custom.graphics.intelMedia.enable = true;` をホスト側で有効化すると `modules/system/graphics/intel-media.nix` から追加できる。
- `hyprpanel` は現状 `nixos-24.11` ではなく `nixos-unstable` 側のパッケージを参照している。
- 置き換える場合は基本的に `modules/iso/minimal/packages.nix` を編集する。
- 将来 `hosts/` や `modules/` に分割した後も、カテゴリ単位で管理すると拡張しやすい。
