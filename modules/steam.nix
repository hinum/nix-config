{pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    lutris
    bottles
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    extraPackages = with pkgs; [
      gamescope
    ];
    extraCompatPackages = with pkgs; [
       proton-ge-bin
     ];
  };
}
