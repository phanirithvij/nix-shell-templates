{ lib, config, ... }:
let
  cfg = config.lang.py;
in
{
  options.lang.py = {
    enable = lib.mkEnableOption "python";
    black.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    ruff.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    treefmtCfg = lib.mkOption {
      description = "pass custom treefmt config";
      type = lib.types.anything;
      default = {
        programs.ruff.enable = cfg.ruff.enable;
        programs.black.enable = cfg.black.enable;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    treefmt-nix.config = cfg.treefmtCfg;
  };
}
