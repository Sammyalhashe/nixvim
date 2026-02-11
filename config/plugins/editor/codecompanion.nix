{
  plugins.codecompanion = {
    enable = true;
    settings = {
      strategies = {
        chat = {
          adapter = "mothership_qwen";
          slash_commands = {
            buffer = {
              callback = "strategies.chat.slash_commands.buffer";
              description = "Insert open buffers";
              opts = {
                contains_code = true;
                provider = "telescope";
              };
            };
            file = {
              callback = "strategies.chat.slash_commands.file";
              description = "Insert a file";
              opts = {
                contains_code = true;
                max_lines = 1000;
                provider = "telescope";
              };
            };
            help = {
              callback = "strategies.chat.slash_commands.help";
              description = "Insert content from help tags";
              opts = {
                contains_code = false;
                provider = "telescope";
              };
            };
            symbols = {
              callback = "strategies.chat.slash_commands.symbols";
              description = "Insert symbols for a selected file";
              opts = {
                contains_code = true;
                provider = "telescope";
              };
            };
          };
          tools = {
            mcp = {
              callback = "require('mcphub.extensions.codecompanion').tool_callback";
              description = "Call tools through MCP Hub";
            };
            files = {
              callback = "strategies.chat.tools.files";
              description = "Read and Write files";
            };
            cmd_runner = {
              callback = "strategies.chat.tools.cmd_runner";
              description = "Run shell commands";
            };
          };
        };
        inline = {
          adapter = "mothership_qwen";
        };
        agent = {
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
