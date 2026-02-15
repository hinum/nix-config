{pkgs, ...}: {

  documentation.man.generateCaches = false; # faster builds
  programs.git.enable = true;
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

    (import ./_shells/fish.nix { inherit pkgs; })
    (import ./_shells/devfish.nix { inherit pkgs; })
    go
    bun
    nodejs
    gcc

    nixd
    gopls
  ];
}
