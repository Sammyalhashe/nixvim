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
          sha256 = "sha256-vpaV1xelIhC6fJS/dINIRqUr4syX+Yo3KUahKp11U1E=";
        };
      })
      
      pkgs.vimPlugins.diffview-nvim
    ];
}
