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
        command = "niri";
        user = "numblr";
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [
      nautilus
      kitty
      libnotify
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
