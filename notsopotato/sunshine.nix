{pkgs, ...}: let

sunshine_apps = pkgs.writeText "sunshine_apps.json" ''
{
  "env": {
    "PATH": "$(PATH):$(HOME)/.local/bin"
  },
  "apps": [
    {
      "name": "Desktop",
      "image-path": "desktop.png"
    }
  ]
}
'';

sunshine_conf = pkgs.writeText "sunshine.conf" ''

locale = en
min_log_level = info
file_apps = ${sunshine_apps}
capture=wlr

global_prep_cmd = []
'';

in {

  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = false;
    package = pkgs.sunshine.override { config.cudaSupport = true; };
  };
  networking = {
    interfaces.enp6s0.wakeOnLan.enable = true;
    firewall.allowedUDPPorts = [ 9 ];
  };

  systemd.user.services.x-sunshine = {
    enable = true;
    description = "sunshine client";
    restartIfChanged = true;
    serviceConfig = {
      ExecStart = "${pkgs.sunshine}/bin/sunshine ${sunshine_conf}";
      RestartSec = 1;
      Restart = "on-failure";
    };
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            f12 = "leftmeta";
          };
        };
      };
    };
  };
}
