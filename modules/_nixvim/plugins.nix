{
  plugins = {
    typst-preview.enable = true;
    treesitter.enable = true;
    web-devicons.enable = true;
    todo-comments.enable = true;

    telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
      };
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
