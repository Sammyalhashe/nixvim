{
  # jj runs `nvim -c "DiffEditor ..."` with no file args, so startup.nvim's
  # VimEnter hook (argc() == 0) would draw the dashboard over hunk.nvim's
  # file-tree window. Skip it when nvim is launched as a diff/merge editor.
  extraConfigLuaPre = ''
    for _, arg in ipairs(vim.v.argv) do
      if arg:match("^DiffEditor ") or arg:match("^MergeEditor ") then
        vim.g.startup_disable_on_startup = true
        break
      end
    end
  '';

  plugins.startup = {
    enable = true;

    settings = {
      colors = {
        background = "#ffffff";
        folded_section = "#ffffff";
      };

      header = {
        type = "text";
        oldfilesDirectory = false;
        align = "center";
        foldSection = false;
        title = "Header";
        margin = 5;
        content = [
          "   █████████    █████████   █████       █████   █████    █████ █████ █████ █████ ███████████"
          "  ███░░░░░███  ███░░░░░███ ░░███       ░░███   ░░███    ░░███ ░░███ ░░███ ░░███ ░█░░░░░░███ "
          " ░███    ░░░  ░███    ░███  ░███        ░███    ░███     ░░███ ███   ░░███ ███  ░     ███░  "
          " ░░█████████  ░███████████  ░███        ░███████████      ░░█████     ░░█████        ███    "
          "  ░░░░░░░░███ ░███░░░░░███  ░███        ░███░░░░░███       ███░███     ░░███        ███     "
          "  ███    ░███ ░███    ░███  ░███      █ ░███    ░███      ███ ░░███     ░███      ████     █"
          " ░░█████████  █████   █████ ███████████ █████   █████ ██ █████ █████    █████    ███████████"
          "  ░░░░░░░░░  ░░░░░   ░░░░░ ░░░░░░░░░░░ ░░░░░   ░░░░░ ░░ ░░░░░ ░░░░░    ░░░░░    ░░░░░░░░░░░ "
        ];
        highlight = "Statement";
        defaultColor = "";
        oldfilesAmount = 0;
      };

      body = {
        type = "mapping";
        oldfilesDirectory = false;
        align = "center";
        foldSection = false;
        title = "Menu";
        margin = 5;
        content = [
          [
            " Find File"
            "lua MiniPick.builtin.files()"
            "ff"
          ]
          [
            "󰍉 Find Word"
            "lua MiniPick.builtin.grep_live()"
            "fr"
          ]
          [
            " Recent Files"
            "lua MiniExtra and MiniExtra.pickers.oldfiles() or MiniPick.builtin.files()"
            "fg"
          ]
          [
            " File Browser"
            "Neotree"
            "fe"
          ]
          [
            " Claude Code"
            "ClaudeCode"
            "cc"
          ]
          [
            "󰧑 SecondBrain"
            "edit ~/projects/personal/SecondBrain"
            "sb"
          ]
        ];
        highlight = "string";
        defaultColor = "";
        oldfilesAmount = 0;
      };

      options = {
        paddings = [
          1
          3
        ];
      };

      parts = [
        "header"
        "body"
      ];
    };
  };
}
