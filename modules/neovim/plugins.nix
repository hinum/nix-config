{...}: {
  programs.nixvim.plugins = {
    treesitter.enable = true;
    web-devicons.enable = true;
    todo-comments.enable = true;
    lualine.enable = true;
    vimtex.enable = true;

    telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
      };
    };
    neo-tree = {
      enable = true;
      settings.window.position = "current";
    };
    noice = {
      enable = true;
      settings = {
        presets.bottom_search = true;
        cmdline.view = "cmdline";
      };
    };
  };
}
