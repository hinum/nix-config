let
  wallpaper = ./configs/hyprland/wallpaper.png;
  configDir = ./configs/hyprland;
  entries = builtins.readDir configDir;
  configfiles = builtins.sort builtins.lessThan (
    builtins.filter
    (name: builtins.match "[a-zA-Z0-9]+[.]conf" name != null)
    (builtins.attrNames entries)
  );
in {
  stylix.targets.hyprland.enable = false;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    extraConfig = builtins.concatStringsSep "\n" (map (name: "source = ${configDir}/${name}") configfiles);
  };

  programs.vicinae = {
    enable = true;
    settings.launcher_window.layer_shell.enabled = false;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };

  services.hyprpaper.enable = true;
  home.file.".config/hypr/hyprpaper.conf".text = ''
    wallpaper {
      monitor =
      path = ${wallpaper}
    }
  '';
}
