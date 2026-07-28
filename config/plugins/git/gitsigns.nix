_: {
  plugins.gitsigns = {
    enable = true;
    settings = {
      signs = {
        add = {
          text = " ";
        };
        change = {
          text = " ";
        };
        delete = {
          text = " ";
        };
        untracked = {
          text = "";
        };
        topdelete = {
          text = "󱂥 ";
        };
        changedelete = {
          text = "󱂧 ";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "]c";
      action.__raw = "function() require('gitsigns').nav_hunk('next') end";
      options.desc = "Next change (hunk)";
    }
    {
      mode = "n";
      key = "[c";
      action.__raw = "function() require('gitsigns').nav_hunk('prev') end";
      options.desc = "Prev change (hunk)";
    }
  ];
}
