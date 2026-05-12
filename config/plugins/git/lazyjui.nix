{ pkgs, ... }:

let
  lazyjui-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "lazyjui.nvim";
    version = "unstable-2026-05-12";
    nvimRequireCheck = "lazyjui.config";
    src = pkgs.fetchFromGitHub {
      owner = "mrdwarf7";
      repo = "lazyjui.nvim";
      rev = "main";
      hash = "sha256-zvNlR833ztEzEKZcqGZ1sIKf2yLo6RqmPRTnn4vBfaM=";
    };
    postInstall = ''
      rm -f $out/lua/lazyjui.lua
    '';
  };
in
{
  extraPlugins = [ lazyjui-nvim ];

  extraPackages = with pkgs; [
    jujutsu
    jjui
  ];

  extraConfigLua = ''
    local ok, lazyjui = pcall(require, "lazyjui")
    if ok then
      lazyjui.setup({
        cmd = { "jjui" },
        height = 0.8,
        width = 0.9,
        winblend = 0,
        use_default_keymaps = true,
        border = {
          chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          thickness = 0,
          winhl_str = "",
        },
      })
    else
      vim.notify("lazyjui failed to load: " .. tostring(lazyjui), vim.log.levels.ERROR)
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>gj";
      action = "<cmd>LazyJui<CR>";
      options = {
        desc = "LazyJUI (jjui)";
      };
    }
  ];
}
