{
  pkgs,
  stable-pkgs,
  self',
  ...
}: {
  documentation.man.cache.enable = false; # faster builds
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
    jq
    home-manager
    wl-clipboard
    tectonic
    zathura
    prismlauncher
    stable-pkgs.inkscape
    file-roller
    mangohud

    self'.starfish
    self'.devfish
    self'.nixvim
    self'.nixos-utils
    self'.noctalia-update

    go
    deno
    nodejs
    quickshell
    tinymist
    typst
    gcc

    nixd
    gopls
  ];
}
