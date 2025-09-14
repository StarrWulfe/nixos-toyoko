{
  description = "A highly modular NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    disko.url = "github:nix-community/disko";
    nixos-anywhere.url = "github:nix-community/nixos-anywhere";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, stylix, disko, nixos-anywhere, ... }@inputs: {
    nixosConfigurations = {
      toyoko = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs stylix home-manager; };
        modules = [ ./hosts/toyoko/default.nix ];
      };
      virtua = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs stylix home-manager; };
        modules = [ ./hosts/virtua/default.nix ];
      };
      randall = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs stylix home-manager disko; };
        modules = [ ./hosts/randall/default.nix ];
      };
    };

    darwinConfigurations = {
      gohan3 = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        specialArgs = { inherit inputs stylix home-manager; };
        modules = [ ./hosts/gohan3/default.nix ];
      };
    };
  };
}