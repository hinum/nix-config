{
  plugins.neo-tree = {
    enable = true;
    settings = {
      window.position = "current";
      default_component_configs = {
        indent = {
          indent_size = 2;
          padding = 1;
          with_markers = false;
          with_expanders = null;
          expander_collapsed = "";
          expander_expanded = "";
          expander_highlight = "NeoTreeExpander";
        };
        git_status = {
          symbols = {
            untracked = "";
            ignored   = "";
            unstaged  = "";
            staged    = "";
            conflict  = "🔥";
          };
        };
        icon = {
          folder_closed = "";
          folder_open = "";
          folder_empty = "";
          default = "*";
          highlight = "NeoTreeFileIcon";
        };
      };

      filesystem = {
        use_libuv_file_watcher = true;
      };
    };
  };
}
