# nixvim/modules/color.nix
{ config, lib, ... }:
with lib;
let
  cfg = config.nixvim;
in
{
  options.nixvim.light = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether to load light mode or not";
  };

  config = mkIf cfg.light {
    colorschemes.catppuccin.settings.flavour = mkForce "latte";
  };
}
