{ config, pkgs, home-manager, pkgsUnstable, ... }:

{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Locale/time
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # User
  users.users.j7 = {
    isNormalUser = true;
    description = "StarrWulfe";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.j7 = (import ../../modules/home-manager/default.nix) { 
    inherit config pkgs pkgsUnstable; 
    programs.bash.enable = true;
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}