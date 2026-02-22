{...}: {
  programs.nixvim.keymaps = [
    {
      key = "<leader>pv";
      action= "<cmd>Neotree<cr>";
    } {
      key = "<leader>ll";
      action= "<cmd>VimtexCompile<cr>";
    } {
      key = "<leader>q";
      action= "<cmd>nohlsearch<cr>";
    } {
      key = "r";
      action= "\"_r";
    } {
      key = "<S-Left>";
      action = "W";
    } {
      key= "<S-Right>";
      action= "B";
    } {
      key = "<S-Up>";
      action= "10k";
    } {
      key = "<S-Down>";
      action = "10j";
    }
  ];
}
