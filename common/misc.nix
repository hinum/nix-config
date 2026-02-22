{pkgs, self', ...}: {

  documentation.man.generateCaches = false; # faster builds
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    firefox
    htop
    home-manager
    wl-clipboard
    tectonic
    zathura
    prismlauncher
    self'.starfish
    self'.devfish

    go
    bun
    nodejs
    quickshell
    gcc

    nixd
    gopls
    texlab
  ];
}
