{...}: {
  programs.nixvim.keymaps = [
    {
      key = "<leader>pv";
      action= "<cmd>Neotree<cr>";
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
      action= "5k";
    } {
      key = "<S-Down>";
      action = "5j";
    }
  ];
}
