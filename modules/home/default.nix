{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  home.username = "j7";
  home.homeDirectory = "/home/j7";

  programs.lazygit.enable = true;

  programs.git = {
    enable = true;
    userName = "starrwulfe";
    userEmail = "jlgatewood@gmail.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      lsa = "eza --tree --icons";
    };
  };

  home.packages = with pkgs; [
    fastfetch
    nh
    fx-cast-bridge
    # ytfzf
    mkchromecast
  ];
}
