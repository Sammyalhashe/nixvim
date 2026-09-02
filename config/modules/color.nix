# nixvim/modules/color.nix
{ config, lib, ... }:
let
  cfg = config.nixvim;
in
{
  options.nixvim = {
    dark = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to load the dark variant of the colorscheme.";
    };

    themeWatcher = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to poll /etc/current-theme and follow the system light/dark setting.";
    };
  };

  # Drives the catppuccin `background` map in plugins/themes; do not pin `flavour`,
  # which would fight the watcher in settings.nix.
  config.opts.background = if cfg.dark then "dark" else "light";
}
