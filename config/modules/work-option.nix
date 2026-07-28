# nixvim/modules/work-option.nix
{ lib, ... }:
{
  options.nixvim.work = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether this is a work build; enables work-specific settings (e.g. the bbgithub enterprise host for octo).";
  };
}
