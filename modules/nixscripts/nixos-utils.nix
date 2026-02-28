{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.nixos-utils = pkgs.buildEnv {
      name = "nixos-utils";
      paths = with self'.packages; [
        nixos-edit
        nixos-clean-generations
      ];
    };
  };
}
