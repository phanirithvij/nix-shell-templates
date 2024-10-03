{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.treefmt-nix;
  inherit (inputs) treefmt-nix devshell;

  devshellsLib =
    (import ../lib/devshells.nix {
      inherit pkgs devshell;
    }).lib;

  treefmtCfg =
    (treefmt-nix.evalModule pkgs (
      _:
      {
        projectRootFile = config.projectRootNixFile;
      }
      // cfg.config
    )).config.build;

  treefmtCmds = devshellsLib.mapCmdPackages {
    packages = (builtins.attrValues treefmtCfg.programs) ++ [
      treefmtCfg.wrapper
    ];
    category = cfg.devshell_category;
  };

  # pass these to out.devshell
  devshellCmds = lib.foldl (a: b: lib.recursiveUpdate a b) { } (
    lib.map (name: {
      devshell.shells.${name}.commands = treefmtCmds;
    }) config.devshell._enabledShells
  );
in
{
  options.treefmt-nix = {
    enable = lib.mkEnableOption "treefmt-nix";
    config = lib.mkOption {
      type = lib.types.anything;
      default = { };
      description = "treefmt-nix partial config";
    };
    # TODO configFull
    configFull = lib.mkOption {
      type = lib.types.anything;
      default = { };
    };
    devshell_category = lib.mkOption {
      type = lib.types.str;
      default = "formatter";
    };
  };
  config = lib.mkIf cfg.enable {
    # TODO assert if configFull specified config should be null/{}
    # TODO if devshell enabled append these to formatting category in devshell's commands
    # But what about multiple shells each with different treefmt-nix configs?
    out = devshellCmds;
  };
}
