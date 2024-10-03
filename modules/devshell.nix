{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  cfg = config.devshell;
  devshellsLib = (import ../lib/devshells.nix { }).lib;
  shellSchema = import ../lib/shell-args.nix args;

  suggestions = devshellsLib.mkShellSuggestions { inherit (cfg) shells; };

  # TODO helper for iterating over all enabled shells
  allShells = lib.mkIf cfg.suggestShells (
    lib.foldl (a: b: lib.recursiveUpdate a b) { } (
      lib.map (name: {
        ${name} = {
          packages =
            cfg.shells.${name}.packages
            ++ lib.optionals cfg.suggestShells (devshellsLib.mkOtherShells cfg.shells name);
          commands = lib.optionals cfg.suggestShells suggestions ++ cfg.shells.${name}.commands;
        };
      }) cfg._enabledShells
    )
  );
in
{
  options.devshell = {
    enable = lib.mkEnableOption "numtide devshell";
    shells = lib.mkOption {
      description = "devshell";
      type = lib.types.attrsOf shellSchema;
      default = { };
    };
    _enabledShells = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = builtins.attrNames (lib.filterAttrs (name: conf: conf.enable) cfg.shells);
      readOnly = true;
      internal = false; # can be accessed in other modules
    };
    suggestShells = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        All the shell menus will have other known shells available in a [shells] category
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    out.devshell.shells = lib.foldl (a: b: lib.recursiveUpdate a b) { } [
      cfg.shells
      allShells
    ];
  };
}
