{pkgs, ...}: {
  programs.niri = {
    enable = true;
    useNautilus = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "niri-session";
        user = "numblr";
      };
    };
  };
  programs.xwayland = {
    enable = true;
    package = pkgs.xwayland-satellite;
  };
  environment = {
    systemPackages = with pkgs; [
      nautilus
      kitty
      libnotify
      gpu-screen-recorder # for a noctalia plugin
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
  systemd.user.services.kitty = {
    enable = true;
    after = ["niri.service"];
    wantedBy = ["graphical-session.target"];

    serviceConfig = {
      ExecStart = "${pkgs.kitty}/bin/kitty --single-instance --listen-on unix:/tmp/spawn-kitty --start-as hidden";
      Restart = "on-failure";
    };
    path = [
      "/run/wrappers"
      "/home/numblr/.nix-profile"
      "/nix/profile"
      "/home/numblr/.local/state/nix/profile"
      "/etc/profiles/per-user/numblr"
      "/nix/var/nix/profiles/default"
      "/run/current-system/sw"
    ];
  };
}
