{ lib, config, ... }:
let
  cfg = config.flake;
in
{
  options = {
    flake = {
      enable = lib.mkEnableOption "flakes";
      contents = lib.mkEnableOption "TODO, freeformtype? a flake type? inputs/desc/out etc.?";
      compat = {
        enable = lib.mkEnableOption "flake-compat" // {
          default = true;
        };
      };
    };
    projectRootNixFile = lib.mkOption {
      type = lib.types.str;
      default = if cfg.enable then "flake.nix" else "shell.nix";
    };
  };
  config = lib.mkIf cfg.enable {
    # todo generate a flake.nix in the template?
    # with what contents?

    # can also have shell.nix generated
  };
}
