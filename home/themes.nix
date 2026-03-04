{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };

  stylix.targets.gtk.enable = false;
  stylix.targets.qt.enable = false;

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    theme = {
      package = pkgs.catppuccin-gtk.override {
        variant = "macchiato";
        accents = ["blue"];
      };
      name = "catppuccin-macchiato-blue-standard";
    };
  };
}
