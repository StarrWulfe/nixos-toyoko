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

  # Light desktop setup (e.g., XFCE)
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

    # System programs/services
  programs.firefox.enable = true;

  # System packages (keep minimal; user tools live in Home Manager)
  environment.systemPackages = with pkgs; [
    flatpak
  ];
}
