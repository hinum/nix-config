{pkgs, ...}: {

  programs.fish.enable = true;
  users.users.numblr = {
    shell = import ../_shells/fish.nix { inherit pkgs; };
    isNormalUser = true;
    description = "numblr";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

