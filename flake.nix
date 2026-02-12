{
  description = "NixOS minimal を土台にした ISO ビルド用 flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    credentials = {
      url = "path:./local/credentials.example.nix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, credentials, ... }:
    let
      system = "x86_64-linux";
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
      };
      credentialsConfig = import credentials;
    in {
      nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit unstablePkgs;
          credentials = credentialsConfig;
        };
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./hosts/iso/minimal/default.nix
        ];
      };

      packages.${system}.iso =
        self.nixosConfigurations.iso.config.system.build.isoImage;
    };
}
