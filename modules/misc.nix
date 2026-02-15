{pkgs, ...}: let

  starfish = (import ./_shells/fish.nix { inherit pkgs; });
  devfish = (import ./_shells/devfish.nix { inherit pkgs; });

in {

  documentation.man.generateCaches = false; # faster builds
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
  environment.sessionVariables = {
    NIX_BUILD_SHELL = "${devfish}/bin/devfish";
  };
  environment.systemPackages = with pkgs; [
    firefox
    htop
    home-manager
    wl-clipboard
    tectonic
    zathura
    starfish
    devfish

    go
    bun
    nodejs
    gcc

    nixd
    gopls
  ];
}
