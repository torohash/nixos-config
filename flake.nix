{
  description = "NixOS minimal を土台にした ISO ビルド用 flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
      };
    in {
      nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ({ lib, pkgs, ... }: {
            isoImage.isoName = lib.mkForce "nixos-minimal-custom.iso";

            programs.hyprland = {
              enable = true;
              xwayland.enable = true;
            };

            environment.systemPackages = with pkgs; [
              ghostty
              fuzzel
              unstablePkgs.hyprpanel
            ];
          })
        ];
      };

      packages.${system}.iso =
        self.nixosConfigurations.iso.config.system.build.isoImage;
    };
}
