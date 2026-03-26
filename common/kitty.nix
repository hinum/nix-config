{pkgs, ...}: {
  systemd.user.services.kitty = {
    enable = true;
    wantedBy = ["graphical-session.target"];

    serviceConfig = {
      ExecStart = "${pkgs.kitty}/bin/kitty --single-instance --listen-on unix:/tmp/spawn-kitty --start-as hidden";
      Restart = "on-failure";
    };
    path = [
      "/run/wrappers"
      "/home/numblr/.nix-profile"
      "/nix/profile"
      "/home/numblr/.local/state/nix/profile"
      "/etc/profiles/per-user/numblr"
      "/nix/var/nix/profiles/default"
      "/run/current-system/sw"
    ];
  };
}
