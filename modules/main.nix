{inputs, self, ...}: let
  homeModules = [
    {
      home.username = "numblr";
      home.homeDirectory = "/home/numblr";
      home.stateVersion = "25.11";
    }
    (inputs.importtree ../home)
  ];
  notsopotatoSystem = "x86_64-linux";

in{
  systems = [ notsopotatoSystem ];

  flake.nixosConfigurations.notsopotato = inputs.nixpkgs.lib.nixosSystem {
    system = notsopotatoSystem;
    specialArgs = {
      inherit self;
      self' = self.packages.${notsopotatoSystem};
    };
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.nixvim.nixosModules.nixvim
      (inputs.importtree ../common)
      (inputs.importtree ../notsopotato)
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
    ];
  };

  flake.homeConfigurations."numblr" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${notsopotatoSystem};
    modules = homeModules ++ [
      inputs.stylix.homeModules.stylix
    ];
  };
}
