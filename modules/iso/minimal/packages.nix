{ pkgs, unstablePkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ghostty
    pkgs.fuzzel
    unstablePkgs.hyprpanel
  ];
}
