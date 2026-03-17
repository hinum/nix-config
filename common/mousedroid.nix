{self', ...}: {
  systemd.user.services.mousedroid = {
    enable = true;
    after = ["niri.service"];
    serviceConfig = {
      ExecStart = "${self'.mousedroid}/bin/mousedroid-deamon";
      Restart = "on-failure";
    };
    wantedBy = ["graphical-session.target"];
  };
  networking.firewall = {
    allowedUDPPorts = [6969];
    allowedTCPPorts = [6969];
  };
}
