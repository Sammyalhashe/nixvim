_: {
  plugins.nvim-ufo = {
    enable = true;
    setupLspCapabilities = true;

    settings = {
      provider_selector.__raw = ''
        function(bufnr, filetype, buftype)
          -- Disable UFO for floating, prompt, terminal, or no-file buffers
          if buftype == "nofile" or buftype == "prompt" or buftype == "terminal" then
            return ""
          end

          -- Disable UFO for mini.pick and unnamed filetypes
          if filetype == "" or filetype == "minipick" or filetype == "mini-pick" then
            return ""
          end

          -- org.nvim folds org buffers itself (TAB cycling). UFO would replace
          -- that with indent folds and re-close them on every edit.
          if filetype == "org" then
            return ""
          end

          -- LSP first: only it reports fold kinds (comment, imports, region).
          -- A provider-selector table allows two providers, so chain all three.
          return function(buf)
            local ufo = require("ufo")
            local function fallback_to(provider)
              return function(err)
                if type(err) == "string" and err:match("UfoFallbackException") then
                  return ufo.getFolds(buf, provider)
                end
                return require("promise").reject(err)
              end
            end
            return ufo.getFolds(buf, "lsp")
              :catch(fallback_to("treesitter"))
              :catch(fallback_to("indent"))
          end
        end
      '';
    };
  };

  opts = {
    foldenable = true;
    foldlevel = 99;
    foldlevelstart = 99;
    foldcolumn = "1";
  };

  keymaps = [
    {
      mode = "n";
      key = "zR";
      action.__raw = "require('ufo').openAllFolds";
      options.desc = "Ufo: Open all folds";
    }
    {
      mode = "n";
      key = "zM";
      action.__raw = "require('ufo').closeAllFolds";
      options.desc = "Ufo: Close all folds";
    }
    {
      mode = "n";
      key = "zr";
      action.__raw = "function() require('ufo').openFoldsExceptKinds({ 'comment', 'imports' }) end";
      options.desc = "Ufo: Open all folds but comments and imports";
    }
    {
      mode = "n";
      key = "zm";
      action.__raw = "require('ufo').closeFoldsWith";
      options.desc = "Ufo: Close folds with level";
    }
    {
      mode = "n";
      key = "zK";
      action.__raw = "function() require('ufo').peekFoldedLinesUnderCursor() end";
      options.desc = "Ufo: Peek folded lines";
    }
  ];
}
