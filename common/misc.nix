{
  pkgs,
  self',
  ...
}: let
  blenderWCuda = pkgs.blender.override {
    cudaSupport = true;
    rocmSupport = false;
  };
in {
  documentation.man.generateCaches = false; # faster builds
  stylix.targets.nixvim.colors.enable = false;
  qt.enable = true; # for qmlls to work properly

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
  environment.variables = {
    EDITOR = "nvim";
  };
  environment.systemPackages = with pkgs; [
    firefox
    htop
    home-manager
    wl-clipboard
    tectonic
    zathura
    prismlauncher
    legcord
    blenderWCuda

    self'.starfish
    self'.devfish
    self'.nixvim
    self'.nixos-utils

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
