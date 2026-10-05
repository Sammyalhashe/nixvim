# nixvim/modules/org-option.nix
{ lib, ... }:
{
  options.nixvim.orgDirectory = lib.mkOption {
    type = lib.types.str;
    default = "~/org";
    description = "Directory org.nvim uses for org files, the agenda and the default notes file.";
  };
}
