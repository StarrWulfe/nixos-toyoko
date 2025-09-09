{
  description = "NixOS + Home Manager (modular setup)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      # Overlay to replace youtube-dl with yt-dlp everywhere
      overlay-ytfix = (final: prev: {
        youtube-dl = final.yt-dlp;
        python3Packages = prev.python3Packages // {
          youtube-dl = final.python3Packages.yt-dlp;
        };
      });

      # Shared package set with overlay applied
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlay-ytfix ];
      };
    in {
      # Home Manager standalone config
      homeConfigurations.toyoko = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };

      # NixOS system config (with Home Manager as a module)
      nixosConfigurations.toyoko = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ overlay-ytfix ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j7 = import ./home.nix;
          }
        ];
      };
    };
}
