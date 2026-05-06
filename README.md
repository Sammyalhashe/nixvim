# NixVim Configuration

This repository contains my personal configuration NixVim, a Neovim configuration managed with Nix.

![Neovim](./.docs/images/neovim.png)

## How to use

You can use this flake as an input:

```nix
{
    inputs = {
        nixvim.url = "github:Sammyalhashe/nixvim"
    };
}
```

You can then install the package either normally or through home-manager.

#### Normal:

```nix
environment.systemPackages = [
    inputs.nixvim.packages.x86_64-linux.default
];
```

#### Home-Manager

```nix
home-manager.users.<user>.home.packages = [
    inputs.nixvim.packages.x86_64-linux.default
];
```

## Configuration Structure

### Core Configuration

The following files define the foundational behavior of Neovim:

- `config/settings.nix`: Core Neovim options (`opts`), clipboard configuration, custom diagnostics signs, and custom terminal commands (`TT`, `VT`, `ST`).
- `config/keymaps.nix`: Global leader key and extensive keybindings for navigation, window management, tabs, and plugin shortcuts.
- `config/auto_cmds.nix`: Global autocommands including yank highlighting, startup screen initialization, and automatic cursor position restoration.
- `config/file_types.nix`: Custom filetype associations (e.g., Terraform, Bicep).

### Custom Modules

Specialized logic and options used across the configuration:

- `config/modules/wsl-option.nix`: Defines a `nixvim.wsl` option for handling WSL-specific environments.
- `config/modules/obsidian-option.nix`: Defines a `nixvim.obsidian` toggle for note-taking features.
- `config/modules/cpp-comments.nix`: Custom comment string and indentation logic for C/C++ files.
- `config/modules/ftplugin/`: Directory for filetype-specific plugin and buffer settings.

### Plugins

Plugins are organized by category in the `config/plugins/` directory:

| Category | Config File | Description |
| :--- | :--- | :--- |
| **Themes** | `config/plugins/themes/default.nix` | Main color scheme and background configuration. |
| **Completion** | `config/plugins/cmp/blink-cmp.nix` | High-performance, modern completion engine. |
| | `config/plugins/cmp/schemastore.nix` | JSON and YAML schema support via SchemaStore. |
| **Snippets** | `config/plugins/snippets/luasnip.nix` | Powerful snippet engine for code expansion. |
| **Editor** | `config/plugins/editor/neo-tree.nix` | Feature-rich file system explorer. |
| | `config/plugins/editor/treesitter.nix` | Advanced syntax highlighting and AST-based features. |
| | `config/plugins/editor/undotree.nix` | Visualizer for the undo history tree. |
| | `config/plugins/editor/illuminate.nix` | Automatic highlighting of other uses of the word under the cursor. |
| | `config/plugins/editor/todo-comments.nix` | Highlighting and searching for TODO, FIXME, and HACK comments. |
| | `config/plugins/editor/claudecode.nix` | Integration with Claude AI for code assistance. |
| | `config/plugins/editor/codecompanion.nix` | AI-powered coding companion. |
| | `config/plugins/editor/mcphub.nix` | Model Context Protocol (MCP) hub integration. |
| | `config/plugins/editor/navic.nix` | Breadcrumbs showing current code context. |
| **UI** | `config/plugins/ui/bufferline.nix` | Modern tab-like bar for open buffers. |
| | `config/plugins/ui/lualine.nix` | Highly configurable status line. |
| | `config/plugins/ui/startup.nix` | Custom greeting/dashboard on startup. |
| | `config/plugins/ui/trouble.nix` | Elegant UI for diagnostics, symbols, and LSP references. |
| **LSP** | `config/plugins/lsp/lsp.nix` | Core LSP client configuration and server management. |
| | `config/plugins/lsp/conform.nix` | Flexible auto-formatting engine. |
| | `config/plugins/lsp/fidget.nix` | UI notifications for LSP progress. |
| **Git** | `config/plugins/git/jiejie-nvim.nix` | Integration for Jujutsu (JJ) version control. |
| | `config/plugins/git/gitsigns.nix` | Git status and blame info in the sign column. |
| | `config/plugins/git/fugitive.nix` | A powerful Git wrapper for Neovim. |
| | `config/plugins/git/lazygit.nix` | TUI for Git (used in specific environments). |
| **Utils** | `config/plugins/utils/mini.nix` | Collection of versatile modules (pickers, indentscope, etc.). |
| | `config/plugins/utils/whichkey.nix` | Interactive popup for keybinding discovery. |
| | `config/plugins/utils/obsidian.nix` | Comprehensive note-taking integration for Obsidian. |
| | `config/plugins/utils/markdown-preview.nix` | Live Markdown rendering in the browser. |
| | `config/plugins/utils/markview.nix` | Enhanced in-buffer Markdown visualization. |
| | `config/plugins/utils/spectre.nix` | Advanced project-wide find and replace. |
| | `config/plugins/utils/toggleterm.nix` | Managed persistent and floating terminal windows. |
| | `config/plugins/utils/extra_plugins.nix` | Loading point for additional external plugins. |

Please refer to the individual `.nix` files for more detailed configuration information.

## References

This configuration has taken inspiration from the following contributors.

- [Elythh](https://github.com/elythh/nixvim)
- [MikaelFangel](https://github.com/MikaelFangel/nixvim-config)
