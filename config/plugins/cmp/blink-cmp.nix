{
  plugins.blink-cmp = {
    enable = true;
    settings = {
      # Use the 'luasnip' preset since the user already uses luasnip
      snippets = {
        preset = "luasnip";
      };

      # Appearance settings to match the previous cmp config (roughly)
      appearance = {
        use_nvim_cmp_as_default = true;
        nerd_font_variant = "mono";
      };

      completion = {
        menu = {
          draw = {
            components = {
              kind_icon = {
                text.__raw = "function(ctx) return require('mini.icons').get('lsp', ctx.kind) end";
                highlight.__raw = "function(ctx) local _, hl, _ = require('mini.icons').get('lsp', ctx.kind) return hl end";
              };
            };
          };
        };
      };

      # Completion sources
      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
        # Note: 'copilot' source might need additional configuration or a separate plugin if blink supports it directly or via compat.
        # blink-cmp has a 'compat' mode for nvim-cmp sources if needed, but native is better.
      };

      # Keymaps
      keymap = {
        preset = "default";
        "<Tab>" = [
          "select_next"
          "snippet_forward"
          "fallback"
        ];
        "<S-Tab>" = [
          "select_prev"
          "snippet_backward"
          "fallback"
        ];
        "<CR>" = [
          "accept"
          "fallback"
        ];
      };
    };
  };
}
