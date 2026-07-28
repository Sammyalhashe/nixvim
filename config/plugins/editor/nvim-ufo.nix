_: {
  plugins.nvim-ufo = {
    enable = true;
    setupLspCapabilities = true;

    settings = {
      provider_selector.__raw = ''
        function(bufnr, filetype, buftype)
          return { 'lsp', 'treesitter' }
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
      action.__raw = "require('ufo').openFoldsExceptKinds";
      options.desc = "Ufo: Open folds except kinds";
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
