{pkgs, ...}: {

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
}
