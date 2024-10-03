{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.lang.md;
in
{
  options.lang.md = {
    enable = lib.mkEnableOption "markdown";
    treefmtCfg = lib.mkOption {
      description = "pass custom treefmt config";
      type = lib.types.anything;
      default = {
        programs.mdsh.enable = true;
        programs.dprint.enable = true;
        programs.dprint.settings.plugins = map toString [ pkgs.dprint-plugins.dprint-plugin-markdown ];
      };
    };
  };
  config = lib.mkIf cfg.enable {
    treefmt-nix.config = cfg.treefmtCfg;
  };
}
