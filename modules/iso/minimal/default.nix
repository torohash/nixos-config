{ ... }:
let
  credentialsPath = ../../../local/credentials.nix;
  credentials =
    if builtins.pathExists credentialsPath then
      import credentialsPath
    else
      throw "local/credentials.nix が見つかりません。local/credentials.example.nix をコピーして作成してください。";
in {
  _module.args = {
    inherit credentials;
  };

  imports = [
    ./assertions.nix
    ./auth-session.nix
    ./desktop-hyprland.nix
    ./packages.nix
  ];
}
