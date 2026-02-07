{pkgs, ...}: {

  programs.hyprland.enable = true;
  environment = {
    systemPackages = with pkgs; [
      kdePackages.dolphin
      kitty
      wofi
    ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
