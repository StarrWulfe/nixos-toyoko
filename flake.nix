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
      pkgs = import nixpkgs { inherit system; };
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
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j7 = import ./home.nix;
          }
        ];
      };
    };
      overlays = [
        (final: prev: {
          python3Packages = prev.python3Packages // {
            youtube-dl = final.yt-dlp;
          };
        })
      ];
    in {
      nixosConfigurations.toyoko = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.j7 = import ./modules/home/default.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
