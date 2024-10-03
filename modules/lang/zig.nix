{ lib, config, ... }:
let
  cfg = config.lang.zig;
in
{
  options.lang.zig = {
    enable = lib.mkEnableOption "zig";
    treefmtCfg = lib.mkOption {
      description = "pass custom treefmt config";
      type = lib.types.anything;
      default = {
        programs.zig.enable = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    treefmt-nix.config = cfg.treefmtCfg;
  };
}
