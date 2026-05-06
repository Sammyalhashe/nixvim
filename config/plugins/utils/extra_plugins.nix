# Extra Plugins
# This file is used to load external Neovim plugins that are not currently packaged as NixVim modules.
{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.plenary-nvim
    (pkgs.vimUtils.buildVimPlugin {
      pname = "mcphub.nvim";
      version = "unstable-2025-01-31";
      doCheck = false;
      src = pkgs.fetchFromGitHub {
        owner = "ravitemer";
        repo = "mcphub.nvim";
        rev = "main";
        sha256 = "009w7iq31k9sx94p3izqnjbgi0gr9fwn7p5wjcaa3kz16jz4znw3";
      };
    })
  ];
}
