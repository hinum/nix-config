{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with self'.packages; [
        devfish
        starfish
        nixvim
      ];
      shellHook = ''
        exec devfish

      '';
    };
  };
}
