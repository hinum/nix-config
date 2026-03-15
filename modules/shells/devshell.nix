{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with self'.packages; [
        nixvim
        pkgs.git
      ];
      shellHook = ''
        exec starfish
      '';
    };
  };
}
