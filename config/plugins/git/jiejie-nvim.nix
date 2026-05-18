{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "jiejie-nvim";
        version = "2026-04";
        src = pkgs.fetchFromGitHub {
          owner = "jceb";
          repo = "jiejie.nvim";
          rev = "7aaaae4a882e25c82dd8504fff05a0cbc619cab6";
          sha256 = "sha256-SGMX5fv39iK+HDcc1DY3elnTWlzm6nCDa73ksT5lyrw=";
        };
      })
      
      pkgs.vimPlugins.diffview-nvim
    ];
}
