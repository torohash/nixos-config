{ config, lib, pkgs, ... }:
let
  cfg = config.custom.graphics.intelMedia;
in {
  options.custom.graphics.intelMedia.enable =
    lib.mkEnableOption "Intel media acceleration packages";

  config = lib.mkIf cfg.enable {
    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];

    environment.sessionVariables.LIBVA_DRIVER_NAME = lib.mkDefault "iHD";
  };
}
