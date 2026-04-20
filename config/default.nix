{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    # import wsl option config
    ./modules/wsl-option.nix
    ./modules/obsidian-option.nix
    ./modules/cpp-comments.nix
    # General Configuration
    ./settings.nix
    ./keymaps.nix
    ./auto_cmds.nix
    ./file_types.nix

    # Themes
    ./plugins/themes

    # Completion
    ./plugins/cmp/blink-cmp.nix
    ./plugins/cmp/schemastore.nix

    # Snippets
    ./plugins/snippets/luasnip.nix

    # Editor plugins and configurations
    ./plugins/editor/neo-tree.nix
    ./plugins/editor/treesitter.nix
    ./plugins/editor/custom-parsers.nix
    ./plugins/editor/undotree.nix
    ./plugins/editor/illuminate.nix
    ./plugins/editor/todo-comments.nix
    ./plugins/editor/claudecode.nix
    ./plugins/editor/codecompanion.nix
    ./plugins/editor/mcphub.nix
    ./plugins/editor/navic.nix

    # UI plugins
    ./plugins/ui/bufferline.nix
    ./plugins/ui/lualine.nix
    ./plugins/ui/startup.nix
    ./plugins/ui/trouble.nix

    # LSP and formatting
    ./plugins/lsp/lsp.nix
    ./plugins/lsp/conform.nix
    ./plugins/lsp/fidget.nix

    # Git
    ./plugins/git/lazygit.nix
    ./plugins/git/gitsigns.nix
    ./plugins/git/fugitive.nix

    # Utils
    ./plugins/utils/extra_plugins.nix
    ./plugins/utils/markdown-preview.nix
    ./plugins/utils/markview.nix
    ./plugins/utils/mini.nix
    ./plugins/utils/obsidian.nix
    ./plugins/utils/spectre.nix
    ./plugins/utils/toggleterm.nix
    ./plugins/utils/whichkey.nix
  ];
}
