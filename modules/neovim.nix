{pkgs, lib, ...}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
    tectonic
    zathura
    nixd
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    keymaps = [
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
        action= "<C-u>";
      } {
        key = "<S-Down>";
        action = "<C-d>";
      }
    ];
    globals.mapleader = " ";
    opts = {
      signcolumn = "yes";
      expandtab = true;
      wrap = false;
      scrolloff = 9999;
      shiftwidth = 2;
      swapfile = false;
    };

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
    plugins = {
      luasnip.enable = true;
      treesitter.enable = true;
      web-devicons.enable = true;
      todo-comments.enable = true;
      lualine.enable = true;
      vimtex.enable = true;
      lspconfig.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
        };
      };
      cmp = let
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
  };
}
