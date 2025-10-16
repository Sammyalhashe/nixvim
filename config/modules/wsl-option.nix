# nixvim/modules/wsl-option.nix
{ config, lib, ... }:
{
  options.nixvim.wsl = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether we are running inside WSL";
  };
}
