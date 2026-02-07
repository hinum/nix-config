{...}: {
  programs.nixvim = {
    lsp = {
      keymaps = [
        {
          key = "gl";
          action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        } {
          key = "<leader>r";
          lspBufAction = "rename";
        } {
          key = "<leader>f";
          lspBufAction = "format";
        } {
          key = "M";
          lspBufAction = "hover";
        }
      ];
      servers = {
        nixd.enable = true;
      };
    };

    plugins.lspconfig.enable = true;
    plugins.luasnip.enable = true;
    plugins.cmp = let
      mapping = {
        "<down>".__raw = "cmp.mapping.select_next_item()";
        "<up>".__raw = "cmp.mapping.select_prev_item()";
        "<tab>".__raw = "cmp.mapping.confirm({ select = true })";
      };
    in {
      enable = true;
      autoEnableSource = true;
      settings.mapping = mapping;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      cmdline ={
        "/" = {
          inherit mapping;
          sources = [{ name = "buffer"; }];
        };
        ":" = {
          inherit mapping;
          sources = [{ name = "cmdline"; }];
        };
      };
    };
  };
}
