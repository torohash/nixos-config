{ lib, ... }:
{
  imports = [
    ../../../modules/iso/minimal/default.nix
  ];

  isoImage.isoName = lib.mkForce "nixos-minimal-custom.iso";
}
