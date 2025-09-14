{ config, pkgs, ... }:

{
  imports = [
    ../../profiles/base/default.nix
    ../../profiles/desktop/xfce.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # File Systems
  fileSystems = {
    "/" = {
      device = "/dev/vda1";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/vda0";
      fsType = "vfat";
    };
  };

  # Host and networking
  networking.hostName = "virtua";
  networking.networkmanager.enable = true;

  # QEMU guest agent
  services.qemuGuest.enable = true;
}