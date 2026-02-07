{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    extraConfig = "source = ${./configs/hyprland.conf}";
  };
}
