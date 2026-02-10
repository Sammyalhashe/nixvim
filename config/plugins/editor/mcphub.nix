{
  extraConfigLua = ''
    require("mcphub").setup({
          port = 3000,
          refresh_interval = 3600,
          config_refresh_interval = 3600,
          servers = {
            ["sequential-thinking"] = {
              command = "npx",
              args = { "-y", "@modelcontextprotocol/server-sequential-thinking" },
            },
          },
        })'';
}
