{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "jiejie-nvim";
        version = "2026-04";
        src = pkgs.fetchFromGitHub {
          owner = "jceb";
          repo = "jiejie.nvim";
          rev = "main";
          sha256 = "sha256-LLx7nYq42gACNsj4eZm1noYTomBTirQ/2vtjtCMXoY0=";
        };
      })
      
      pkgs.vimPlugins.diffview-nvim
    ];
}
