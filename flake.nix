{
  description = "Sammy's NixVim configuration (forked from DecorTech)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
    };
  };

  outputs =
    {
      nixvim,
      flake-parts,
      pre-commit-hooks,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      flake = {
        nixvimModules.wslOption = import ./config/modules/wsl-option.nix;
        # ✅ Expose nixvimFunctions per system using self'
        nixvimFunctions = {
          x86_64-linux = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule;
          aarch64-linux = inputs.nixvim.legacyPackages.aarch64-linux.makeNixvimWithModule;
          x86_64-darwin = inputs.nixvim.legacyPackages.x86_64-darwin.makeNixvimWithModule;
          aarch64-darwin = inputs.nixvim.legacyPackages.aarch64-darwin.makeNixvimWithModule;
        };
      };

      perSystem =
        {
          system,
          pkgs,
          self',
          lib,
          ...
        }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
              wsl = false;
            };
          };
          wslModule = {
            inherit pkgs;
            module = import ./config/wsl.nix; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
              wsl = true;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
          wsl = nixvim'.makeNixvimWithModule wslModule;
        in
        {
          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                statix.enable = true;
                nixfmt-rfc-style.enable = true;
              };
            };
          };

          formatter = pkgs.nixfmt-rfc-style;

          packages = {
            default = nvim;
            inherit wsl;
          };

          devShells = {
            default = with pkgs; mkShell { inherit (self'.checks.pre-commit-check) shellHook; };
          };
        };
    };
}
