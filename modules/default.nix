{
  pkgs ? import sources.nixpkgs { },
  sources ? import ../npins,
  modules ? [ ],
}:
let
  # TODO see also nix-community.github.io/haumea
  # all files which are not default.nix are modules?
  # TODO change this dumb decision later
  all-modules =
    builtins.filter (p: (lib.strings.hasSuffix ".nix" p && builtins.baseNameOf p != "default.nix"))
      (
        builtins.map builtins.toString (
          builtins.filter (p: p != ./default.nix) (lib.filesystem.listFilesRecursive ./.)
        )
      );
  inherit (pkgs) lib;
  result = lib.evalModules {
    modules = all-modules ++ modules;
    specialArgs = {
      inherit pkgs;
      inputs = {
        treefmt-nix = import sources.treefmt-nix;
        devshell = import sources.devshell { nixpkgs = pkgs; };
        inherit (sources) ides;
      };
    };
  };
in
result
