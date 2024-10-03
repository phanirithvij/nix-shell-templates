{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.lang.go;

  pkgsCmds = lib.mapAttrs (name: v: {
    inherit (cfg) packages commands;
  }) config.devshell.shells;
in
{
  options.lang.go = {
    enable = lib.mkEnableOption "go";
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.anything; # TODO anything -> proper type
      default = [ ];
    };
    commands = lib.mkOption {
      type = lib.types.listOf lib.types.anything; # TODO anything -> proper type
      default = [
        {
          package = pkgs.golangci-lint;
          category = "tools";
        }
      ];
    };
    treefmtCfg = lib.mkOption {
      description = "pass custom treefmt config";
      type = lib.types.anything;
      default = {
        programs.gofumpt.enable = true;
        programs.golines.enable = true;
        programs.templ.enable = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    treefmt-nix.config = cfg.treefmtCfg;
    out.devshell.shells = pkgsCmds;
  };
}
