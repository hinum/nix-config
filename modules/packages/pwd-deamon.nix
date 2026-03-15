{
  perSystem = {pkgs, ...}: {
    packages.pwd-deamon = pkgs.buildGoModule {
      name = "pwd-deamon";
      src = ./pwd-deamon;
      vendorHash = null;
    };
  };
}
