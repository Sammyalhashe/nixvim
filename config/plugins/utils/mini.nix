{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;

    modules = {
      ai = { };
      icons = { };
      snippets = {
        snippets.__raw = ''
          {
            function()
              local snippets = {}
              local ft = vim.bo.filetype

              if vim.tbl_contains({ 'cpp', 'c' }, ft) then
                table.insert(snippets, {
                  prefix = 'guard',
                  desc = 'Include guard',
                  body = '#ifndef INCLUDED_$1\n#define INCLUDED_$1\n\n$0\n\n#endif // INCLUDED_$1',
                })
              end

              if ft == 'markdown' then
                table.insert(snippets, {
                  prefix = 'es',
                  desc = 'End slide (presenterm)',
                  body = '<!-- end_slide -->',
                })
              end

              return snippets
            end,
          }
        '';
        mappings = {
          expand = "<C-j>";
          jump_next = "<C-l>";
          jump_prev = "<C-h>";
          stop = "<C-c>";
        };
      };
      indentscope = {
        symbol = "│";
        options = {
          try_as_border = true;
        };
      };
      move = { };
      pairs = { };
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
