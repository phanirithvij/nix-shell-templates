{ lib, config, ... }:
let
  cfg = config.lang.bash;
in
{
  options.lang.bash = {
    enable = lib.mkEnableOption "bash";
    treefmtCfg = lib.mkOption {
      description = "pass custom treefmt config";
      type = lib.types.anything;
      default = {
        programs.shellcheck.enable = true;
        programs.shfmt.enable = true;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    treefmt-nix.config = cfg.treefmtCfg;
  };
}
