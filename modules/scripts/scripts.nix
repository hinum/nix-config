{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.scripts = pkgs.buildEnv {
      name = "scripts";
      paths = with self'.packages; [
        nixos-edit
        nixos-clean-generations
        noctalia-update
        bundle-nixvim
      ];
    };
  };
}
