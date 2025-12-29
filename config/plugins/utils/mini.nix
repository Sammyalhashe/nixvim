{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;

    modules = {
      icons = { };
      indentscope = {
        symbol = "│";
        options = {
          try_as_border = true;
        };
      };
      surround = { };

      # cmdline = { };

      pick = {
        mappings = {
          move_down = "<C-j>";
          move_up = "<C-k>";
          scroll_down = "<C-d>";
          scroll_up = "<C-f>";
          choose_marked = "<M-m>";
        };
      };
    };
  };
}
