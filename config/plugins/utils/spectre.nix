{
  plugins.spectre = {
    enable = true;
  };

  extraConfigLua = ''
    vim.keymap.set("n", "<leader>rr", "<cmd>Spectre<cr>", { desc = "Replace (Spectre)" })
  '';
}
