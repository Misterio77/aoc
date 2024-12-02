{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    systems.url = "github:nix-systems/default-linux";
    gitignore.url = "github:hercules-ci/gitignore.nix";
    gitignore.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    systems,
    gitignore,
    ...
  }: let
    eachSystem = f:
      nixpkgs.lib.genAttrs (import systems) (system:
        f {
          packages = self.outputs.packages.${system};
          pkgs = nixpkgs.legacyPackages.${system};
          lib = nixpkgs.lib;
        });
  in {
    packages = eachSystem ({pkgs, ...}: {
      default = pkgs.haskellPackages.developPackage {
        name = "aoc";
        root = gitignore.lib.gitignoreSource ./.;
      };
    });
    devShells = eachSystem ({pkgs, packages, ...}: {
      default = pkgs.mkShell {
        inputsFrom = [packages.default];
        buildInputs = [
          pkgs.aoc-cli
          pkgs.haskellPackages.ghc
          pkgs.haskellPackages.cabal-install
          pkgs.haskellPackages.haskell-language-server
          pkgs.haskellPackages.hoogle
        ];
      };
    });
  };
}
