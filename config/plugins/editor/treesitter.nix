{ pkgs, lib, ... }:
{
  # 1. Use the NixVim Treesitter module instead of manual extraPlugins
  # This avoids "two different versions of nvim-treesitter" conflicts.
  plugins.treesitter = {
    enable = true;

    settings = {
      # Disable the plugin's own highlighting to use Neovim's native highlighting
      highlight.enable = false;
      indent.enable = true;
    };

    # Bundle grammars
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      # Primary languages
      c
      cpp
      python
      javascript
      typescript
      tsx
      ocaml

      # Config/markup
      nix
      lua
      vim
      vimdoc
      json
      yaml
      toml
      markdown
      markdown_inline
      html
      css

      # Shell/infra
      bash
      dockerfile
      terraform
      go
      regex
      query
    ];
  };

  # 2. Enable Native Highlighting (Neovim 0.12 style)
  autoCmd = [
    {
      event = [ "FileType" ];
      desc = "Enable native treesitter highlighting";
      callback.__raw = ''
        function()
          local buf = vim.api.nvim_get_current_buf()
          pcall(vim.treesitter.start, buf)
        end
      '';
    }
  ];

  # 3. Native Folding
  opts = {
    foldmethod = lib.mkForce "expr";
    foldexpr = lib.mkForce "v:lua.vim.treesitter.foldexpr()";
    foldlevel = lib.mkForce 99;
  };
}
