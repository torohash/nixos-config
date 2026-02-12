{ pkgs, unstablePkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = import ../../packages/default.nix {
    inherit pkgs unstablePkgs;
  };
}
