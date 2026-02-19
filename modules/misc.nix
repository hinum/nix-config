{pkgs, ...}: let

  starfish = (import ./_shells/fish.nix { inherit pkgs; });
  devfish = (import ./_shells/devfish.nix { inherit pkgs; });

in {

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
    starfish
    devfish

    go
    bun
    nodejs
    quickshell
    gcc

    nixd
    gopls
  ];
}
