{self', ...}: {
  systemd.user.services.mousedroid = {
    wantedBy = ["niri.service"];
    serviceConfig = {
      ExecStart = "${self'.mousedroid}/bin/mousedroid-deamon";
      Restart = "on-failure";
    };
  };
  networking.firewall = {
    allowedUDPPorts = [6969];
    allowedTCPPorts = [6969];
  };
}
