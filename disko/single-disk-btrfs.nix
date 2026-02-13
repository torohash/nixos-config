{ disk ? "/dev/disk/by-id/CHANGEME", ... }:
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = disk;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            start = "1MiB";
            end = "1025MiB";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/efi";
              mountOptions = [ "umask=0077" ];
            };
          };

          boot = {
            start = "1025MiB";
            end = "3073MiB";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/boot";
            };
          };

          root = {
            start = "3073MiB";
            end = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-L" "nixos" "-f" ];
              subvolumes = {
                root00 = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd:1" "ssd" "discard=async" ];
                };

                home00 = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd:1" "ssd" "discard=async" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
