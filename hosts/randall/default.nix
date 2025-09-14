{ config, pkgs, disko, ... }:

{
  imports = [
    disko.nixosModules.disko
    ./disko.nix
    ../../profiles/base/default.nix
    ../../profiles/desktop/xfce.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Host and networking
  networking.hostName = "randall";
  networking.networkmanager.enable = true;
}
