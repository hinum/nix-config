{
  perSystem = {pkgs, ...}: {
    packages.mousedroid = pkgs.buildGoModule {
      name = "mousedroid";
      src = ./mousedroid-deamon;
      vendorHash = null;
      postInstall = ''
        cp icon.png $out/icon.png
      '';
    };
  };
}
