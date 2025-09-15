{
  description = "A highly modular NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    disko.url = "github:nix-community/disko";
    nixos-anywhere.url = "github:nix-community/nixos-anywhere";
    nh.url = "github:viperML/nh";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, stylix, disko, nixos-anywhere, nh, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    pkgsUnstable = import nixpkgs-unstable { inherit system; };
  in {
    nixosConfigurations = {
      toyoko = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs stylix home-manager pkgsUnstable; };
        modules = [ ./hosts/toyoko/default.nix ];
      };
      virtua = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs stylix home-manager pkgsUnstable; };
        modules = [ ./hosts/virtua/default.nix ];
      };
      randall = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs stylix home-manager disko pkgsUnstable; };
        modules = [ ./hosts/randall/default.nix ];
      };
    };

    darwinConfigurations = {
      gohan3 = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        specialArgs = { inherit inputs stylix home-manager pkgsUnstable; };
        modules = [ ./hosts/gohan3/default.nix ];
      };
    };

    homeConfigurations = {
      toyoko = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs stylix pkgsUnstable; };
        modules = [ ./modules/home-manager/default.nix ];
      };
      virtua = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs stylix pkgsUnstable; };
        modules = [ ./modules/home-manager/default.nix ];
      };
      randall = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs stylix pkgsUnstable; };
        modules = [ ./modules/home-manager/default.nix ];
      };
      gohan3 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        extraSpecialArgs = { inherit inputs stylix pkgsUnstable; };
        modules = [ ./modules/home-manager/default.nix ];
      };
    };
  };
}