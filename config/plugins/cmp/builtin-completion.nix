{
  opts.completeopt = "menuone,noselect,popup";

  autoGroups = {
    builtin_lsp_completion = { };
  };

  autoCmd = [
    {
      group = "builtin_lsp_completion";
      event = [ "LspAttach" ];
      callback = {
        __raw = ''
          function(ev)
            local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
            if client:supports_method('textDocument/completion') then
              -- Trigger on every word character, not just server-defined triggerCharacters
              local chars = {}
              for i = string.byte('a'), string.byte('z') do table.insert(chars, string.char(i)) end
              for i = string.byte('A'), string.byte('Z') do table.insert(chars, string.char(i)) end
              for i = string.byte('0'), string.byte('9') do table.insert(chars, string.char(i)) end
              table.insert(chars, '_')
              client.server_capabilities.completionProvider.triggerCharacters = chars

              vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = true,
                convert = function(item)
                  local icons = require('mini.icons')
                  local icon, _, _ = icons.get('lsp', item.kind and vim.lsp.protocol.CompletionItemKind[item.kind] or 'Text')
                  return { abbr = icon .. ' ' .. item.label }
                end,
              })
            end
          end
        '';
      };
    }
  ];

  keymaps = [
    {
      mode = [ "i" ];
      key = "<Tab>";
      action.__raw = ''
        function()
          if vim.fn.pumvisible() == 1 then
            return '<C-n>'
          elseif require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
            return ""
          else
            -- Trigger buffer completion when no LSP popup
            return '<C-n>'
          end
        end
      '';
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = [ "i" ];
      key = "<S-Tab>";
      action.__raw = ''
        function()
          if vim.fn.pumvisible() == 1 then
            return '<C-p>'
          elseif require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
            return ""
          else
            return '<S-Tab>'
          end
        end
      '';
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      mode = [ "i" ];
      key = "<CR>";
      action.__raw = ''
        function()
          if vim.fn.pumvisible() == 1 then
            return '<C-y>'
          else
            return '<CR>'
          end
        end
      '';
      options = {
        expr = true;
        silent = true;
      };
    }
  ];
}
