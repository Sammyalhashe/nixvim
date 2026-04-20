{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    settings = {
      indent.enable = true;
      highlight.enable = true;
    };
    folding = false;
    nixvimInjections = true;
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

}
