{pkgs, ...}: {

  documentation.man.generateCaches = false; # faster builds
  programs.git.enable = true;
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    firefox
    home-manager
    wl-clipboard
    tectonic
    zathura

    nixd
  ];
}
