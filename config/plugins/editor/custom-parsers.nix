{ pkgs, lib, config, ... }:
let
  parsersDir = "~/.local/share/tree-sitter/parsers";
in
{
  # Add a custom parsers directory to Neovim's runtime path.
  # Parser .so files live in parser/, query files in queries/.
  # Silently skipped on hosts where the directory is absent.
  extraConfigLua = ''
    local parsers_dir = vim.fn.expand("${parsersDir}")
    if vim.fn.isdirectory(parsers_dir) == 1 then
      vim.opt.runtimepath:append(parsers_dir)
    end

    vim.filetype.add({
      extension = {
        dmptest = "dmptest",
        dmptool = "dmptool",
      },
    })
    vim.treesitter.language.register("dmptest", "dmptest")
    vim.treesitter.language.register("dmptool", "dmptool")
  '';

  # C++ injection query for dmptest DSL in string literals.
  # highlights.scm files are loaded from the parsers directory
  # at runtime via the runtimepath.
  extraFiles = {
    "after/queries/cpp/injections.scm".text = ''
      ; extends

      ((string_content) @injection.content
        (#match? @injection.content "^(Sub|Resub|Unsub|ReqRecap|UpdateSub|LockModel|UnlockModel|RelockModel|SubEvent|SubResp|ResubResp|ResolveResp|Update|Recap)\\(")
        (#set! injection.language "dmptest"))
    '';
  };
}
