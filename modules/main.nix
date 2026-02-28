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
  specialArgs = {
    inherit self;
    stable-pkgs = inputs.nixpkgs-stable.legacyPackages.${notsopotatoSystem};
    self' = self.packages.${notsopotatoSystem};
  };
in {
  systems = [notsopotatoSystem];

  flake.nixosConfigurations.notsopotato = inputs.nixpkgs.lib.nixosSystem {
    inherit specialArgs;
    system = notsopotatoSystem;
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.nixvim.nixosModules.nixvim
      (inputs.importtree ../common)
      (inputs.importtree ../notsopotato)
      {
        home-manager = {
          extraSpecialArgs = specialArgs;
          backupFileExtension = "backup";
          overwriteBackup = true;
          users.numblr.imports = homeModules;
        };
      }
    ];
  };

  flake.homeConfigurations."numblr" = inputs.home-manager.lib.homeManagerConfiguration {
    inherit specialArgs;
    pkgs = inputs.nixpkgs.legacyPackages.${notsopotatoSystem};
    modules =
      homeModules
      ++ [
        inputs.stylix.homeModules.stylix
      ];
  };
}
