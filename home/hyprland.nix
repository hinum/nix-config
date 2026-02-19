{pkgs, ...}: let 

  configDir = ./configs/hyprland;
  entries = builtins.readDir configDir;
  configfiles =
    builtins.sort builtins.lessThan (
    builtins.filter
      (name: entries.${name} == "regular" && name != "declare.conf")
      (builtins.attrNames entries));

in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    extraConfig = builtins.concatStringsSep "\n" (map (name: "source = ${configDir}/${name}") configfiles);
  };
}
