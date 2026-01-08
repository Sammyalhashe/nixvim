{
  pkgs,
  ...
}:
{
  extraPackages = [ pkgs.gemini-cli ];
  plugins.codecompanion = {
    enable = true;
    settings = {
      interactions = {
        chat = {
          adapter = "gemini_cli";
        };
      };
      adapters = {
        acp = {
          gemini_cli = {
            __raw = ''
              function()
                return require("codecompanion.adapters").extend("gemini_cli", {
                  defaults = {
                    auth_method = "oauth-personal",
                  },
                })
              end
            '';
          };
        };
      };
    };
  };
}
