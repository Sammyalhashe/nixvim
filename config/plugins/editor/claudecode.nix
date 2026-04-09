{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.snacks-nvim
    (pkgs.vimUtils.buildVimPlugin {
      name = "claudecode.nvim";
      doCheck = false;
      src = pkgs.fetchFromGitHub {
        owner = "coder";
        repo = "claudecode.nvim";
        rev = "432121f0f5b9bda041030d1e9e83b7ba3a93dd8f";
        sha256 = "0px4ppw9mlackb4ljp1cy56xm0m0p75z1bz6kg6wrbxcji941j5g";
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
        auto_start = true,
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
