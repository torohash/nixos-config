{ lib, ... }:
{
  imports = [
    ../../modules/iso/default.nix
  ];

  isoImage.isoName = lib.mkForce "nixos-minimal-custom.iso";
}
