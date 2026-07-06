{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    nui-nvim
    hunk-nvim
  ];

  extraConfigLua = ''
    require("hunk").setup()
  '';
}
