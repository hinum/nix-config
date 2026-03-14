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
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        screen-recorder = {
          enable = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
  };
}
