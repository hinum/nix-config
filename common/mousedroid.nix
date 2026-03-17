{self', ...}: {
  environment.systemPackages = [self'.mousedroid];
  services.udev.packages = [self'.mousedroid];
  networking.firewall = {
    allowedUDPPorts = [6969];
    allowedTCPPorts = [6969];
  };
}
