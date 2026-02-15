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
      catppuccin-qt5ct
      thunar
      kitty
      wofi
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "x11";
    };
  };
}
