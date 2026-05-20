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

              if vim.tbl_contains({ 'cpp', 'c', 'java', 'javascript', 'typescript', 'go', 'rust' }, ft) then
                table.insert(snippets, {
                  prefix = 'hdr',
                  desc = 'Section header comment block',
                  body = '// ''${1/./-/g}\n// ''${1:text}\n// ''${1/./-/g}',
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
