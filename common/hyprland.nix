{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "start-hyprland";
        user = "numblr";
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [
      thunar
      kitty
      vicinae
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
  systemd.user.services.vicinae = {
    name = "vicinae server";
    enable = true;
    wantedBy = ["graphical-session.target"];

    serviceConfig = {
      ExecStart = "${pkgs.vicinae}/bin/vicinae server";
      RestartSec = "2s";
      Restart = "on-failure";
    };
  };
}
