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

      overlay-ytfix = (final: prev: {
        youtube-dl = final.yt-dlp;
        python3Packages = prev.python3Packages // {
          youtube-dl = final.python3Packages.yt-dlp;
        };
      });

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlay-ytfix ];
      };
    in {
      # Standalone Home Manager config
      homeConfigurations.toyoko = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./modules/home/default.nix
        ];
      };

      # NixOS system config with Home Manager as a module
      nixosConfigurations.toyoko = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ overlay-ytfix ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j7 = import ./modules/home/default.nix;
          }
        ];
      };
    };
}
