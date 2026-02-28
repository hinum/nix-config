{
  inputs,
  self,
  ...
}: let
  homeModules = [
    {
      home.username = "numblr";
      home.homeDirectory = "/home/numblr";
      home.stateVersion = "25.11";
    }
    (inputs.importtree ../home)
  ];
  notsopotatoSystem = "x86_64-linux";
in {
  systems = [notsopotatoSystem];

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
    modules =
      homeModules
      ++ [
        inputs.stylix.homeModules.stylix
      ];
  };
}
