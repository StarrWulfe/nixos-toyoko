{
  description = "A very basic flake to build on...";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs }: {
     nixosConfigurations.toyoko = nixpkgs.lib.nixosSystem {
       modules = [ ./configuration.nix ];
       };
  };
}
