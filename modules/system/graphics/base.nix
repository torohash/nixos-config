{ lib, ... }:
{
  services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault false;
  };
}
