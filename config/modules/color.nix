# nixvim/modules/color.nix
{ config, lib, ... }:
with lib;
let
  cfg = config.nixvim.dark;
in
{
  options.nixvim.dark = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "If dark theme is enabled. Otherwise light";
  };

  config = {
    catpuccin.settings.flavour = mkForce (if cfg.dark then "mocha" else "latte");
  };
}
