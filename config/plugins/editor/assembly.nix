{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "AssemblyForNeovim";
      version = "2026-10-09";
      src = pkgs.fetchFromGitHub {
        owner = "0xdeadf1sh";
        repo = "AssemblyForNeovim";
        rev = "148cec5132fb9c382ef41b71eca801b88b569349";
        hash = "sha256-MOhSunOsH3Gjhs10VGlMoi62/VxZH4Bf8gBScB4AMGk=";
      };
    })
  ];

  # :Asm and <leader>a show the assembly for C, C++ and Rust code
  extraConfigLua = ''
    require("asm").setup()
  '';
}
