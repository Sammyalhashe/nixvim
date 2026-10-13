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
        lib.banner = ./config/banner.txt;

        nixvimModules = {
          wslOption = import ./config/modules/wsl-option.nix;
          obsidianOption = import ./config/modules/obsidian-option.nix;
          workOption = import ./config/modules/work-option.nix;
          colorOption = import ./config/modules/color.nix;
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
          # Build a module, parameterized by whether this is a work build.
          mkModule = work: {
            inherit pkgs;
            module = {
              imports = [ ./config ]; # import the module directly
              nixvim.work = work;
            };
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
              wsl = false;
            };
          };
          nixvimModule = mkModule false;
          workModule = mkModule true;
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
          nvimWork = nixvim'.makeNixvimWithModule workModule;
          banner =
            pkgs.runCommand "banner.txt"
              { nativeBuildInputs = [ (pkgs.python3.withPackages (ps: [ ps.pyfiglet ])) ]; }
              ''
                python3 -c '
                import pyfiglet
                art = pyfiglet.figlet_format("SALH.XYZ", font="dos_rebel", width=200)
                lines = [l.rstrip() for l in art.splitlines() if l.strip()]
                width = max(map(len, lines))
                print("\n".join(l.ljust(width) for l in lines))
                ' > $out
              '';
        in
        {
          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
            work = nixvimLib.check.mkTestDerivationFromNixvimModule workModule;
            banner = pkgs.runCommand "banner-up-to-date" { } ''
              diff -u ${./config/banner.txt} ${banner} \
                || { echo "Regenerate: nix build .#banner && cp result config/banner.txt"; exit 1; }
              touch $out
            '';
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                statix.enable = true;
                nixfmt.enable = true;
              };
            };
          };

          formatter = pkgs.nixfmt-tree;

          packages = {
            default = nvim;
            work = nvimWork;
            inherit banner;
          };

          devShells = {
            default = with pkgs; mkShell { inherit (self'.checks.pre-commit-check) shellHook; };
          };
        };
    };
}
