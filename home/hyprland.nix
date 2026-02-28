let
  configDir = ./configs/hyprland;
  entries = builtins.readDir configDir;
  configfiles = builtins.sort builtins.lessThan (
    builtins.filter
    (name: entries.${name} == "regular")
    (builtins.attrNames entries)
  );
in {
  stylix.targets.hyprland.enable = false;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    extraConfig = builtins.concatStringsSep "\n" (map (name: "source = ${configDir}/${name}") configfiles);
  };
}
