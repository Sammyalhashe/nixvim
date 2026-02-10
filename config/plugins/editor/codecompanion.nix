{
  plugins.codecompanion = {
    enable = true;
    settings = {
      strategies = {
        chat = {
          adapter = "mothership_qwen";
          tools = {
            mcp = {
              callback = "require('mcphub.extensions.codecompanion').tool_callback";
              description = "Call tools through MCP Hub";
            };
          };
        };
        inline = {
          adapter = "mothership_qwen";
        };
      };
      adapters = {
        mothership_qwen = {
          __raw = ''
            function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                          env = {
                            url = "http://11.125.37.101:8012",
                            api_key = "none",
                          },
                          schema = {
                            model = {
                              default = "qwen2.5-coder-32b-instruct",
                            },
                          },
                        })
                      end'';
        };
      };
    };
  };
}
