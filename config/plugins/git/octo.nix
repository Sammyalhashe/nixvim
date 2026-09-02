{
  config,
  lib,
  pkgs,
  ...
}:
{
  plugins.octo = {
    enable = true;
    # Pinned to pwntester/octo.nvim@5ae580d rather than tracking nixpkgs.
    package = pkgs.vimPlugins.octo-nvim.overrideAttrs (_: {
      name = "vimplugin-octo.nvim-0-unstable-2026-01-22";
      src = pkgs.fetchFromGitHub {
        owner = "pwntester";
        repo = "octo.nvim";
        rev = "5ae580df72589f25b775ff2bdacfd7f7be8d63bd";
        hash = "sha256-lIQS/PNjQb4DSIfHBagYjcIw4Kz4HTZDlcCgSVdZ580=";
      };
    });
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
