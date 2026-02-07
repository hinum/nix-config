{pkgs, ...}: {

  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = true;

    applications = {
      apps = [
        {
          name = "Desktop";
          prep-cmd = [
            {
              do = ''
                hyprctl keyword monitor SUNSHINE,$\{SUNSHINE_CLIENT_WIDTH}x$\{SUNSHINE_CLIENT_HEIGHT}@$\{SUNSHINE_CLIENT_FPS},auto,1
              '';
              undo = ''
                hyprctl keyword monitor SUNSHINE,disable
              '';
            }
          ];
          auto-detach = "true";
        }
      ];
    };
  };
  networking = {
    interfaces.enp6s0.wakeOnLan.enable = true;
    firewall.allowedUDPPorts = [ 9 ];
  };
}
