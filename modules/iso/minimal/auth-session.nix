{ lib, pkgs, credentials, ... }:
let
  defaultUsername = credentials.default_username or "";
  defaultPassword = credentials.default_password or "";
in {
  users.users.${defaultUsername} = {
    isNormalUser = true;
    description = defaultUsername;
    extraGroups = [ "wheel" ];
    initialPassword = defaultPassword;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd '${pkgs.hyprland}/bin/Hyprland --config /etc/xdg/hypr/hyprland.conf'";
        user = "greeter";
      };
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland --config /etc/xdg/hypr/hyprland.conf";
        user = defaultUsername;
      };
    };
  };

  security.sudo.wheelNeedsPassword = lib.mkForce true;
}
