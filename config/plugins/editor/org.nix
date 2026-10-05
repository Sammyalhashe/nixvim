{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "org.nvim";
      version = "unstable-2026-10-04";
      nvimRequireCheck = "org";
      src = pkgs.fetchFromGitHub {
        owner = "xheisenbugx";
        repo = "org.nvim";
        rev = "ad5d9805b65a1e0c901030877f3bedd6b4278d48";
        hash = "sha256-XPzVHsxkpKb0Kk4As1wQM2GWgdpeFRXUTjRQNI7lZN4=";
      };
    })
  ];

  extraConfigLua = ''
    require("org").setup({
      org_directory = "~/org",
      agenda_files = { "~/org/**/*.org" },
      default_notes_file = "~/org/refile.org",
    })
  '';
}
