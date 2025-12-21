{
  extraConfigLuaPre = ''
    _G.get_evil_color = function(name)
      local hl_map = {
        red = "DiagnosticError",
        green = "String",
        blue = "Function",
        yellow = "DiagnosticWarn",
        cyan = "DiagnosticInfo",
        magenta = "Keyword",
        orange = "Number",
        violet = "Statement",
        white = "Normal",
        fg = "Normal",
      }
      local group = hl_map[name] or "Normal"
      local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
      local fg = hl.fg and string.format("#%06x", hl.fg) or "NONE"
      return fg
    end

    _G.evil_conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }
  '';
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
        extensions = [
          "fzf"
          "neo-tree"
        ];
        disabledFiletypes = {
          statusline = [
            "startup"
            "alpha"
          ];
        };
        theme = "catppuccin";
        component_separators = "";
        section_separators = "";
      };
      sections = {
        lualine_a = [];
        lualine_b = [];
        lualine_y = [];
        lualine_z = [];
        lualine_c = [
          {
            __unkeyed-1.__raw = "function() return '▊' end";
            color.__raw = "function() return { fg = _G.get_evil_color('blue') } end";
            padding = {
              left = 0;
              right = 1;
            };
          }
          {
            __unkeyed-1.__raw = "function() return '' end";
            color.__raw = ''
              function()
                local mode_color = {
                  n = _G.get_evil_color("red"),
                  i = _G.get_evil_color("green"),
                  v = _G.get_evil_color("blue"),
                  ["\22"] = _G.get_evil_color("blue"),
                  V = _G.get_evil_color("blue"),
                  c = _G.get_evil_color("magenta"),
                  no = _G.get_evil_color("red"),
                  s = _G.get_evil_color("orange"),
                  S = _G.get_evil_color("orange"),
                  ["\19"] = _G.get_evil_color("orange"),
                  ic = _G.get_evil_color("yellow"),
                  R = _G.get_evil_color("violet"),
                  Rv = _G.get_evil_color("violet"),
                  cv = _G.get_evil_color("red"),
                  ce = _G.get_evil_color("red"),
                  r = _G.get_evil_color("cyan"),
                  rm = _G.get_evil_color("cyan"),
                  ["r?"] = _G.get_evil_color("cyan"),
                  ["!"] = _G.get_evil_color("red"),
                  t = _G.get_evil_color("red")
                }
                return { fg = mode_color[vim.fn.mode()] }
              end
            '';
            padding = {
              right = 1;
            };
          }
          {
            __unkeyed-1 = "filesize";
            cond.__raw = "_G.evil_conditions.buffer_not_empty";
          }
          {
            __unkeyed-1 = "filename";
            cond.__raw = "_G.evil_conditions.buffer_not_empty";
            color.__raw = "function() return { fg = _G.get_evil_color('magenta'), gui = 'bold' } end";
          }
          {
            __unkeyed-1 = "location";
          }
          {
            __unkeyed-1 = "progress";
            color.__raw = "function() return { fg = _G.get_evil_color('fg'), gui = 'bold' } end";
          }
          {
            __unkeyed-1 = "diagnostics";
            sources = [
              "nvim_diagnostic"
            ];
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
            };
            diagnostics_color = {
              error.__raw = "function() return { fg = _G.get_evil_color('red') } end";
              warn.__raw = "function() return { fg = _G.get_evil_color('yellow') } end";
              info.__raw = "function() return { fg = _G.get_evil_color('cyan') } end";
            };
          }
          {
            __unkeyed-1.__raw = "function() return '%=' end";
          }
          {
            __unkeyed-1.__raw = ''
              function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                local clients = vim.lsp.get_clients()
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
            icon = " LSP:";
            color.__raw = "function() return { fg = _G.get_evil_color('white'), gui = 'bold' } end";
          }
        ];
        lualine_x = [
          {
            __unkeyed-1.__raw = ''
              function()
                local icon = " "
                local status = require("copilot.api").status.data
                return icon .. (status.message or " ")
              end
            '';
            cond.__raw = ''
              function()
               local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
               return ok and #clients > 0
              end
            '';
            color.__raw = "function() return { fg = _G.get_evil_color('green') } end";
          }
          {
            __unkeyed-1 = "o:encoding";
            fmt.__raw = "string.upper";
            cond.__raw = "_G.evil_conditions.hide_in_width";
            color.__raw = "function() return { fg = _G.get_evil_color('green'), gui = 'bold' } end";
          }
          {
            __unkeyed-1 = "fileformat";
            fmt.__raw = "string.upper";
            icons_enabled = false;
            color.__raw = "function() return { fg = _G.get_evil_color('green'), gui = 'bold' } end";
          }
          {
            __unkeyed-1 = "branch";
            icon = "";
            color.__raw = "function() return { fg = _G.get_evil_color('violet'), gui = 'bold' } end";
          }
          {
            __unkeyed-1 = "diff";
            symbols = {
              added = " ";
              modified = "󰝤 ";
              removed = " ";
            };
            diff_color = {
              added.__raw = "function() return { fg = _G.get_evil_color('green') } end";
              modified.__raw = "function() return { fg = _G.get_evil_color('orange') } end";
              removed.__raw = "function() return { fg = _G.get_evil_color('red') } end";
            };
            cond.__raw = "_G.evil_conditions.hide_in_width";
          }
          {
            __unkeyed-1.__raw = "function() return '▊' end";
            color.__raw = "function() return { fg = _G.get_evil_color('blue') } end";
            padding = {
              left = 1;
            };
          }
        ];
        inactive_sections = {
          lualine_a = [];
          lualine_b = [];
          lualine_y = [];
          lualine_z = [];
          lualine_c = [];
          lualine_x = [];
        };
      };
    };
  };
}
