{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    importtree.url = "github:vic/import-tree";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... } @ inputs: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    homeModules = [
      {
        home.username = "numblr";
        home.homeDirectory = "/home/numblr";
        home.stateVersion = "25.11";
      }
      (inputs.importtree ./home)
    ];
  in {
    nixosConfigurations.notsopotato = nixpkgs.lib.nixosSystem {
      modules = [
        {
          # only change if you know what youre doing (apparently)
          system.stateVersion = "25.11";
          nixpkgs.config.allowUnfree = true;
          nix.settings = {
            experimental-features = ["nix-command" "flakes"];
            substituters = [ "https://cache.nixos-cuda.org" ];
            trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
          };
          nix.gc = {
            automatic = true;
            dates = "1 day";
          };
          home-manager = {
            backupFileExtension = "backup";
            overwriteBackup = true;
            users.numblr.imports = homeModules;
          };
        }
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.nixvim.nixosModules.nixvim
        (inputs.importtree ./modules)
      ];
    };
    homeConfigurations."numblr" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = homeModules ++ [
        inputs.stylix.homeModules.stylix
      ];
    };
  };
}
