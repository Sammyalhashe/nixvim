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
        kind_icons = {
          Text = "󰊄";
          Method = "";
          Function = "󰡱";
          Constructor = "";
          Field = "";
          Variable = "󱀍";
          Class = "";
          Interface = "";
          Module = "󰕳";
          Property = "";
          Unit = "";
          Value = "";
          Enum = "";
          Keyword = "";
          Snippet = "";
          Color = "";
          File = "";
          Reference = "";
          Folder = "";
          EnumMember = "";
          Constant = "";
          Struct = "";
          Event = "";
          Operator = "";
          TypeParameter = "";
          Copilot = "";
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
        # Add custom keymaps here if needed to match the user's previous preference
        # The user had <C-d>, <C-f>, <C-e>, <CR>, <Tab>, <S-Tab>
        # 'default' preset covers most, but Tab handling might need explicit config if they want super-tab behavior.
        # For now, default is a safe start.
      };
    };
  };
}
