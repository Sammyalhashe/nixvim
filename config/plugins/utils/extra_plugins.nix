{
  pkgs,
  ...
}:
{
  extraPlugins = [
    pkgs.vimPlugins.plenary-nvim
    (pkgs.vimUtils.buildVimPlugin {
      name = "mcphub.nvim";
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
