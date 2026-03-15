{self', ...}: {
  systemd.user.services.pwd-deamon = {
    enable = true;
    wantedBy = ["default.target"];

    serviceConfig = {
      ExecStart = "${self'.pwd-deamon}/bin/pwd-deamon";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}
