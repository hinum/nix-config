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
    vlc
    socat
    tldr
    alacritty

    self'.starfish
    self'.devfish
    self'.nixvim
    self'.scripts
    go
    deno
    nodejs
    quickshell
    typst
    gcc
    alejandra
    python3

    nixd
    gopls
    tinymist
    nodePackages."@tailwindcss/language-server"
    nodePackages.svelte-language-server
  ];
}
