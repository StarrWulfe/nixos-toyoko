{ config, pkgs, ... }:

{
  imports = [
    stylix.homeManagerModules.stylix
  ];

  home.stateVersion = "25.05";

  home.username = "j7";
  home.homeDirectory = "/home/j7";

  # --- Program configs ---
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

      # Mimic youtube-tui: interactive search + download/stream with yt-dlp
      ytui = "ytfzf -D --downloader yt-dlp";

      # Search, extract direct URL, and cast via go-chromecast
      # Tip: add --video or --audio flags to ytfzf to prefer stream types
      ytcast = "ytfzf -D --downloader yt-dlp --no-video | xargs -r go-chromecast load";
    };
  };

  # --- User packages (moved from system) ---
  home.packages = with pkgs; [
    # Your originals
    fastfetch
    nh
    fx-cast-bridge
    ytfzf
    yt-dlp
    go-chromecast
    localsend
    bitwarden
    vscode
    beeper
    google-chrome
    onlyoffice-bin

    # CLI and dev tools (moved from system)
    neovim
    micro
    tealdeer
    xclip
    bat
    eza
    fzf
    zoxide
    zellij
    git

    # Bleeding edge from unstable (not sure if that overlay in flake.nix is needed)
    pkgsUnstable.yazi
    pkgsUnstable.ghostty
  
  ];
}