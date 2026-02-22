{...}: {
  stylix.targets.nixvim.colors.enable = false;
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    termguicolors = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "machiatto";
    };

    globals.mapleader = " ";
    opts = {
      signcolumn = "yes";
      expandtab = true;
      wrap = false;
      scrolloff = 9999;

      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      swapfile = false;
    };
  };
}
