{
  pkgs,
  lib,
  ...
}: {
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = true;
    package = pkgs.sunshine.override {
      config.cudaSupport = true;
      # TODO: removed this (this was added to fix an unstable update)
      boost = pkgs.boost187;
    };
  };
  systemd.user.services.sunshine = {
    after = ["niri.service"];
    serviceConfig = {
      Restart = lib.mkForce "always";
      RestartSec = lib.mkForce "0.1s";
    };
  };
  networking = {
    interfaces.enp6s0.wakeOnLan.enable = true;
    firewall.allowedUDPPorts = [9];
  };
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            f12 = "leftmeta";
          };
        };
      };
    };
  };
}
