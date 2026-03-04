{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.cascadia-code;
        name = "Cascadia code";
      };
    };
  };

  stylix.targets.gtk.enable = false;
  stylix.targets.qt.enable = false;
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };
}
