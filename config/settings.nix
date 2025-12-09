{ pkgs, ... }:
{
  config = {
    extraConfigLuaPre =
      # lua
      ''
        vim.fn.sign_define("diagnosticsignerror", { text = " ", texthl = "diagnosticerror", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsignwarn", { text = " ", texthl = "diagnosticwarn", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsignhint", { text = "󰌵", texthl = "diagnostichint", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsigninfo", { text = " ", texthl = "diagnosticinfo", linehl = "", numhl = "" })
      '';

    extraConfigLua = ''
      vim.api.nvim_create_user_command("TT", "tabnew | term", {})
      vim.api.nvim_create_user_command("VT", "vsplit | term", {})
      vim.api.nvim_create_user_command("ST", "split | term", {})

      vim.g.disable_autoformat = true;

      -- Theme switching
      local timer = vim.loop.new_timer()
      timer:start(0, 2000, vim.schedule_wrap(function()
          local f = io.open("/etc/current-theme", "r")
          if f then
              local content = f:read("*all")
              f:close()
              content = content:gsub("%s+", "")
              if content == "light" then
                  if vim.o.background ~= "light" then
                      vim.o.background = "light"
                  end
              else
                  if vim.o.background ~= "dark" then
                      vim.o.background = "dark"
                  end
              end
          else
               if vim.o.background ~= "dark" then
                  vim.o.background = "dark"
              end
          end
      end))
    '';

    clipboard = {
      providers.wl-copy.enable = pkgs.stdenv.isLinux;
    };

    opts = {
      # ignore case
      ignorecase = true;
      smartcase = true;

      # Show line numbers
      number = true;

      # Show relative line numbers
      relativenumber = true;

      # Use the system clipboard
      clipboard = "unnamedplus";

      # Number of spaces that represent a <TAB>
      tabstop = 4;
      softtabstop = 4;

      # Show tabline always
      showtabline = 2;

      # Use spaces instead of tabs
      expandtab = true;

      # I used this in my old config so why not
      smarttab = true;

      # Enable smart indentation
      smartindent = true;

      # Number of spaces to use for each step of (auto)indent
      shiftwidth = 4;

      # Enable break indent
      breakindent = true;

      # Highlight the screen line of the cursor
      cursorline = true;

      # Minimum number of screen lines to keep above and below the cursor
      scrolloff = 8;

      # Enable mouse support
      mouse = "a";

      # Set folding method to manual
      foldmethod = "manual";

      # Disable folding by default
      foldenable = false;

      # Wrap long lines at a character in 'breakat'
      linebreak = true;

      # Disable spell checking
      spell = false;

      # Disable swap file creation
      swapfile = false;

      # Time in milliseconds to wait for a mapped sequence to complete
      timeoutlen = 300;

      # Enable 24-bit RGB color in the TUI
      termguicolors = true;

      # Don't show mode in the command line
      showmode = false;

      # Open new split below the current window
      splitbelow = true;

      # Keep the screen when splitting
      splitkeep = "screen";

      # Open new split to the right of the current window
      splitright = true;

      # Hide command line unless needed
      cmdheight = 0;

      # Remove EOB
      fillchars = {
        eob = " ";
      };
    };
  };
}
