{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    importtree.url = "github:vic/import-tree";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations.notsopotato = nixpkgs.lib.nixosSystem {
      modules = [
        inputs.nixvim.nixosModules.nixvim
        (inputs.importtree ./modules)
      ];
    };
  };
}
