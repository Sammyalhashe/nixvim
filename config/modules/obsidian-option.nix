# nixvim/modules/obsidian-option.nix
{ config, lib, ... }:
{
  options.nixvim.obsidian = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether we enable wsl";
  };
}
