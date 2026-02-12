{
  description = "NixOS minimal を土台にした ISO ビルド用 flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ({ lib, ... }: {
            isoImage.isoName = lib.mkForce "nixos-minimal-custom.iso";
          })
        ];
      };

      packages.${system}.iso =
        self.nixosConfigurations.iso.config.system.build.isoImage;
    };
}
