{
  plugins.mini = {
    enable = true;

    modules = {
      indentscope = {
        symbol = "│";
        options = {
          try_as_border = true;
        };
      };
      surround = { };

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
