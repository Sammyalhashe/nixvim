{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    lazygit-nvim
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options = {
        desc = "LazyGit (root dir)";
      };
    }
  ];
}
