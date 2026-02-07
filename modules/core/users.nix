{pkgs, ...}: {

  programs.fish.enable = true;
  users.users.numblr = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "numblr";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

