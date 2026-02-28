{self', ...}: {
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Visut Hsu";
        email = "visuthsu@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
  programs.fish.enable = true;
  users.users.numblr = {
    shell = self'.starfish;
    isNormalUser = true;
    description = "numblr";
    extraGroups = ["networkmanager" "wheel" "video"];
  };
}
