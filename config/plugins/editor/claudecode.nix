{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.snacks-nvim
    (pkgs.vimUtils.buildVimPlugin {
      pname = "claudecode.nvim";
      version = "v0.3.0";
      doCheck = true;
      src = pkgs.fetchFromGitHub {
        owner = "coder";
        repo = "claudecode.nvim";
        tag = "v0.3.0";
        hash = "sha256-sOBY2y/buInf+SxLwz6uYlUouDULwebY/nmDlbFbGa8=";
      };
    })
  ];

  extraConfigLua = ''
    do
      -- If ANTHROPIC_BASE_URL is set in the environment, forward it to the
      -- claude subprocess so it hits the local LiteLLM proxy instead of
      -- Anthropic's API. Otherwise leave env empty and let the CLI default.
      local claude_env = {}
      local base_url = os.getenv("ANTHROPIC_BASE_URL")
      if base_url and base_url ~= "" then
        claude_env.ANTHROPIC_BASE_URL = base_url
        local api_key = os.getenv("ANTHROPIC_API_KEY")
        if api_key and api_key ~= "" then
          claude_env.ANTHROPIC_API_KEY = api_key
        else
          claude_env.ANTHROPIC_API_KEY = "sk-no-key-required"
        end
      end

      require("claudecode").setup({
        -- Only auto-start when there's a real UI attached. In headless mode
        -- (e.g. the nixvim build-time check / CI) starting the integration
        -- emits a "stopped" message on exit that fails the check.
        auto_start = #vim.api.nvim_list_uis() > 0,
        log_level = "info",
        track_selection = true,
        env = claude_env,
        terminal = {
          provider = "snacks",
          split_side = "right",
          split_width_percentage = 0.35,
          auto_close = true,
        },
        diff_opts = {
          layout = "vertical",
        },
      })

      -- Keymaps (mirrors the <leader>c prefix used by the old copilot-chat)
      local map = vim.keymap.set
      map("n", "<leader>ct", "<cmd>ClaudeCode<cr>",             { desc = "Toggle Claude Code" })
      map("n", "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",        { desc = "Focus Claude Code" })
      map("n", "<leader>cr", "<cmd>ClaudeCode --resume<cr>",    { desc = "Resume Claude session" })
      map("n", "<leader>cc", "<cmd>ClaudeCode --continue<cr>",  { desc = "Continue Claude session" })
      map("n", "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>",  { desc = "Select model" })
      map("n", "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",        { desc = "Add buffer to context" })
      map("v", "<leader>cs", "<cmd>ClaudeCodeSend<cr>",         { desc = "Send selection to Claude" })
      map("n", "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>",   { desc = "Accept diff" })
      map("n", "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",     { desc = "Reject diff" })
    end
  '';
}
