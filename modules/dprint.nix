{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dprint;
  pkg = cfg.package;
in
{
  options.dprint = {
    enable = lib.mkEnableOption "dprint";
    package = lib.mkPackageOption pkgs "dprint" { };
    treefmtCfg = lib.mkOption {
      description = "pass custom treefmt config";
      type = lib.types.anything;
      default = {
        programs.dprint = {
          enable = true;
          package = pkg;
          includes = [
            "**/*.{md,json,jsonc,toml,yml,yaml}"
            "*.{md,json,jsonc,toml,yml,yaml}"
          ];
          excludes = [
            "**/node_modules"
            "**/*-lock.json"
          ];
          settings = {
            plugins = map toString (
              with pkgs.dprint-plugins;
              [
                dprint-plugin-json
                dprint-plugin-markdown
                dprint-plugin-toml
                g-plane-pretty_yaml
              ]
            );
          };
        };
      };
    };
  };
  config = lib.mkIf cfg.enable {
    treefmt-nix.config = cfg.treefmtCfg;
  };
}
