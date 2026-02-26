{pkgs, lib, ...}:{

  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = false;
    package = pkgs.sunshine.override { config.cudaSupport = true; };
  };
  systemd.user.services.sunshine = {
    serviceConfig = { RestartSec = lib.mkForce "1s"; };
  };
  networking = {
    interfaces.enp6s0.wakeOnLan.enable = true;
    firewall.allowedUDPPorts = [ 9 ];
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
