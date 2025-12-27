{ pkgs, ... }:
{
  plugins = {
    lsp-lines = {
      enable = true;
    };
    lsp-format = {
      enable = true;
    };
    helm = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        zls = {
          enable = true;
        };
        cmake = {
          enable = true;
        };
        html = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        nil_ls = {
          enable = true;
        };
        ts_ls = {
          enable = true;
        };
        marksman = {
          enable = true;
        };
        pyright = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        terraformls = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
        ocamllsp = {
          enable = true;
          package = null;
        };
        clangd = {
          enable = true;
          cmd = [
            "clangd"
            "--background-index"
            "--clang-tidy"
            "--header-insertion=iwyu"
            "--completion-style=detailed"
          ];

          # Filetypes
          filetypes = [
            "c"
            "cpp"
            "objc"
            "objcpp"
            "cuda"
          ];

          # Root directory detection
          rootMarkers = [
            ".clangd"
            "compile_commands.json"
            ".git"
            "CMakeLists.txt"
          ];
        };
        helm_ls = {
          enable = true;
          extraOptions = {
            settings = {
              "helm_ls" = {
                yamlls = {
                  path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
                };
              };
            };
          };
        };
        yamlls = {
          enable = true;
          extraOptions = {
            settings = {
              yaml = {
                schemas = {
                  kubernetes = "'*.yaml";
                  "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
                  "http://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
                  "http://json.schemastore.org/ansible-stable-2.9" = "roles/tasks/*.{yml,yaml}";
                  "http://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
                  "http://json.schemastore.org/ansible-playbook" = "*play*.{yml,yaml}";
                  "http://json.schemastore.org/chart" = "Chart.{yml,yaml}";
                  "https://json.schemastore.org/dependabot-v2" = ".github/dependabot.{yml,yaml}";
                  "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" =
                    "*docker-compose*.{yml,yaml}";
                  "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" =
                    "*flow*.{yml,yaml}";
                };
              };
            };
          };
        };
      };

      keymaps = {
        silent = true;
        extra = [
          {
            key = "]h";
            action = ":LspClangdSwitchSourceHeader<cr>";
          }
        ];
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          # gr = {
          #   # action = "references";
          #   desc = "Goto References";
          # };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>ar" = {
            action = "rename";
            desc = "Rename";
          };
        };
        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
    ansible-vim
  ];

  extraConfigLua = ''
        local _border = "rounded"

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, {
            border = _border
          }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help, {
            border = _border
          }
        )

        vim.diagnostic.config{
          float={border=_border}
        };

        require('lspconfig.ui.windows').default_options = {
          border = _border
        }

    -- Trouble LSP keymaps (replaces lspBuf gr/gI/etc)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buf = args.buf
        local trouble = require("trouble")
        
        vim.keymap.set("n", "<Space>gr", function()
          trouble.open("lsp_references")
          trouble.focus()
        end, { buffer = buf, desc = "LSP References (Trouble)" })
        
        -- vim.keymap.set("n", "gI", function()
        --   trouble.open("lsp_implementations")
        -- end, { buffer = buf, desc = "LSP Implementations (Trouble)" })
        --
        -- vim.keymap.set("n", "gD", function()
        --   trouble.open("lsp_declarations")
        -- end, { buffer = buf, desc = "LSP Declarations (Trouble)" })
        --
        -- vim.keymap.set("n", "gT", function()
        --   trouble.open("lsp_type_definitions")
        -- end, { buffer = buf, desc = "LSP Type Definitions (Trouble)" })
      end
    })
  '';
}
