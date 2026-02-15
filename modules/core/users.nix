{pkgs, ...}: {

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Visut Hsu";
        email = "visuthsu@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
  programs.fish.enable = true;
  users.users.numblr = {
    shell = import ../_shells/fish.nix { inherit pkgs; };
    isNormalUser = true;
    description = "numblr";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

