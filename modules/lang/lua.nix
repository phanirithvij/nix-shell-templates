{ lib, config, ... }:
let
  cfg = config.lang.lua;
in
{
  options.lang.lua = {
    enable = lib.mkEnableOption "lua";
    treefmtCfg = lib.mkOption {
      description = "pass custom treefmt config";
      type = lib.types.anything;
      default = {
        programs.stylua.enable = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    treefmt-nix.config = cfg.treefmtCfg;
  };
}
