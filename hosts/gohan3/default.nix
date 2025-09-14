{ config, pkgs, ... }:

{
  imports = [
    ../../profiles/base/default.nix
  ];

  # Host and networking
  networking.hostName = "gohan3";

  # System packages
  environment.systemPackages = with pkgs; [
  ];

  # Nix-Darwin specific settings
  system.stateVersion = 4;
}
