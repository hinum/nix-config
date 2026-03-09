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
        pkgs.git
      ];
      shellHook = ''
        exec starfish
      '';
    };
  };
}
