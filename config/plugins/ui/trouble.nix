{
  plugins.trouble = {
    enable = true;
    settings = {
      auto_close = true;
      focus = true;
      extraLuaConfig = ''
        -- Trouble window keymaps
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "Trouble",
          callback = function()
            local opts = { buffer = true, silent = true }
            vim.keymap.set("n", "?", "<cmd>Trouble help<cr>", opts)
            vim.keymap.set("n", "<cr>", "<cmd>Trouble jump<cr>", opts)
            vim.keymap.set("n", "o", "<cmd>Trouble jump<cr>", opts)
            vim.keymap.set("n", "p", "<cmd>Trouble toggle preview<cr>", opts)
            vim.keymap.set("n", "<space>", "<cmd>Trouble toggle fold<cr>", opts)
            vim.keymap.set("n", "q", "<cmd>Trouble close<cr>", opts)
            vim.keymap.set("n", "R", "<cmd>Trouble refresh<cr>", opts)
          end
        })
      '';
    };
  };
}
