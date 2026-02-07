{...}: {
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
      swapfile = false;
    };
  };
}
