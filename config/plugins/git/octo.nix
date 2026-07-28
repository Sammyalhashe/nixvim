{ config, lib, ... }:
{
  plugins.octo = {
    enable = true;
    settings = {
      picker = "fzf-lua";
    }
    // lib.optionalAttrs config.nixvim.work {
      github_hostname = "bbgithub.dev.bloomberg.com";
    };
  };

  # octo auto-enables fzf-lua + adds the gh CLI via nixvim `dependencies`.
  # Set explicitly for robustness against future default changes.
  plugins.fzf-lua.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>op";
      action = "<cmd>Octo pr list<CR>";
      options.desc = "Octo: PR list";
    }
    {
      mode = "n";
      key = "<leader>oi";
      action = "<cmd>Octo issue list<CR>";
      options.desc = "Octo: Issue list";
    }
    {
      mode = "n";
      key = "<leader>or";
      action = "<cmd>Octo review start<CR>";
      options.desc = "Octo: Review start";
    }
    {
      mode = "n";
      key = "<leader>oo";
      action = "<cmd>Octo actions<CR>";
      options.desc = "Octo: Actions";
    }
  ];
}
