{ config, pkgs, stylix, ... }:

{
  imports = [
    stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    image = ../../modules/nixos/wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.overpass;
        name = "Overpass Nerd font";
      };
    };
  };

  # Display/desktop
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Input (example)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Audio (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  # System programs/services
  programs.firefox.enable = true;

  # System packages (keep minimal; user tools live in Home Manager)
  environment.systemPackages = with pkgs; [
    flatpak
  ];
}
