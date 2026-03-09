{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.cascadia-code;
        name = "Cascadia Code NF";
      };
    };
  };

  fonts = {
    packages = with pkgs; [
      sarabun-font
    ];
  };

  stylix.targets.gtk.enable = false;
  stylix.targets.qt.enable = false;
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };
}
