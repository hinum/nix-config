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
}
