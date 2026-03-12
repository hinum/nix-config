{lib, ...}: let
  rawconfig = builtins.fromJSON (builtins.readFile ./configs/noctalia.json);
  config =
    rawconfig
    // {
      wallpaper.directory = "${./wallpapers}";
    };
in {
  programs.noctalia-shell = {
    enable = true;
    settings = lib.mkForce config;
  };
}
