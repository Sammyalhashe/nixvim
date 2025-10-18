{
  config,
  lib,
  pkgs,
  ...
}:
let
  notesPath =
    if config.nixvim.wsl then "/mnt/c/Users/sammy/Syncthing/My notes" else "/home/salhashemi2/My notes";
in
{
  plugins.obsidian = {
    enable = true;
    settings = {
      workspaces = [
        {
          name = "SecondBrain";
          path = notesPath;
        }
      ];
      opts.legacy_commands = false;
      templates = {
        subdir = "templates";
        dateFormat = "%Y-%m-%d";
        timeFormat = "%H:%M";
        substitutions = { };
      };

      dailyNotes = {
        folder = "0_Daily_Notes";
        dateFormat = "%Y-%m-%d";
        aliasFormat = "%B %-d, %Y";
      };
    };
  };
}
