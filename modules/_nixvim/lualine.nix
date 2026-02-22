{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        component_separators = { left = " "; right = " " ;};
        section_separators = { left = " "; right = " "; };
        always_divide_middle = true;
        globalstatus = false;
      };
      sections = {
        lualine_a = ["mode"];
        lualine_b = ["branch"];
        lualine_c = ["filename"];
        lualine_x = [
        "diagnostics"
        {
          __unkeyed-1 = {
            __raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.bo[0].filetype
                  local clients = vim.lsp.get_clients({ bufnr = 0 })
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
          };
          icon = "";
        }];
        lualine_y = [
          "diff"
          {
            __unkeyed-1 = {
              __raw = ''
                function()
                  local recordReg = vim.fn.reg_recording()
                  if recordReg == "" then return "" end
                  return "󰑊 " .. recordReg
                end
              '';
            };
            color = { fg = "#e78284"; };
          }
        ];
        lualine_z = [ "location" ];
      };
      inactive_sections = {
        lualine_c = ["filename"];
        lualine_x = ["location"];
      };
      winbar = {};
      inactive_winbar = {};
    };
  };
}
