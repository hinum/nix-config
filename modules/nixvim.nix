{inputs, ...}: let
  nixvim = inputs.nixvim;
in {
  perSystem = {system, ...}: let
    nixvimLib = nixvim.lib.${system};
    nixvim' = nixvim.legacyPackages.${system};
    nixvimModule = {
      inherit system; # or alternatively, set `pkgs`
      module.imports = [
        (inputs.importtree ./_nixvim)
      ];
    };
    nvim = nixvim'.makeNixvimWithModule nixvimModule;
  in {
    checks = {
      # Run `nix flake check .` to verify that your config is not broken
      nixvim = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
    };
    packages = {
      # Lets you run `nix run .` to start nixvim
      nixvim = nvim;
    };
  };
}
