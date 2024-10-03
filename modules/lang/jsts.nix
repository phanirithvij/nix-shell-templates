{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.lang.jsts;
in
{
  options.lang.jsts = {
    enable = lib.mkEnableOption "js/ts";
    treefmtCfg = lib.mkOption {
      description = "pass custom treefmt config";
      type = lib.types.anything;
      default = {
        programs.dprint.enable = true;
        programs.dprint.settings.plugins = map toString [
          pkgs.dprint-plugins.dprint-plugin-json
          pkgs.dprint-plugins.dprint-plugin-typescript
        ];
      };
    };
  };
  config = lib.mkIf cfg.enable {
    treefmt-nix.config = cfg.treefmtCfg;
  };
}
