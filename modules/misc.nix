{pkgs, ...}: {

  documentation.man.generateCaches = false; # faster builds
  programs.git.enable = true;
  environment.systemPackages = with pkgs; [
    firefox
    htop
    home-manager
    wl-clipboard
    tectonic
    zathura

    go
    bun
    nodejs
    gcc

    nixd
    gopls
  ];
}
