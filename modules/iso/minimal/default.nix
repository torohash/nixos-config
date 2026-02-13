{ ... }:
{
  imports = [
    ../../system/graphics/default.nix
    ./assertions.nix
    ./auth-session.nix
    ./desktop-hyprland.nix
    ./hyprland-config.nix
    ./networking.nix
    ./packages.nix
  ];
}
