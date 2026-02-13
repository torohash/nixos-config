{ lib, ... }:
{
  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;

  programs.nm-applet.enable = true;
}
