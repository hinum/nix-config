{pkgs, ...}: let 

qt_config = {
  Appearance = {
    style = "Darkly";
    color_scheme_path="/home/numblr/.nix-profile/share/qt5ct/colors/catppuccin-macchiato-red.conf";
    custom_palette = "true";
    standar_dialogs = "default";
  };
};

in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    extraConfig = "source = ${./configs/hyprland.conf}";
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
  };

  stylix.targets.gtk.enable = false;
  stylix.targets.qt.enable = false;

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.package = with pkgs; [
      darkly-qt5
      darkly
      catppuccin-qt5ct
    ];
    qt5ctSettings = qt_config;
    qt6ctSettings = qt_config;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    theme = {
      package = (pkgs.catppuccin-gtk.override { 
        variant = "macchiato";
        accents = ["red"];
      });
      name = "catppuccin-macchiato-red-standard";
    };
  };
}
