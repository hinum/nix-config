{...}: {

  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = false;
  };
  networking = {
    interfaces.enp6s0.wakeOnLan.enable = true;
    firewall.allowedUDPPorts = [ 9 ];
  };
}
