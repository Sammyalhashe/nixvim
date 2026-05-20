_: {
  plugins.markview = {
    enable = true;
    settings = {
      preview = {
        enable = true;
      };
      extraConfig = ''
        vim.api.nvim_set_keymap("n", "<leader>s", "<CMD>Markview splitToggle<CR>", { desc = "Toggles `splitview` for current buffer"})
      '';
    };
  };
}
