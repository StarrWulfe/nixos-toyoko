{ config, pkgs, ... }:

{
  home.username = "j7";
  home.homeDirectory = "/home/j7";
  home.stateVersion = "25.05";

  programs.bash.enable = true;
  home.packages = with pkgs; [ hello ];
}
