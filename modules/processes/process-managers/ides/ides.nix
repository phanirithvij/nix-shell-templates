{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  cfg = config.services;

  inherit (inputs) ides;
  mkIdes = import ides {
    # optional instantiation args
    inherit pkgs;
    shell = pkgs.mkShell.override {
      stdenv = pkgs.stdenvNoCC;
    };
    modules = [ ];
  };
in
{
  options.services = {
    enable = lib.mkEnableOption "ides services";
    out = lib.mkOption {
      type = lib.types.anything;
      default = { };
    };
  };
  config = lib.mkIf cfg.enable {
    services.out = mkIdes {
      imports = [ ./services/caddy ];
      services.redis = {
        enable = true;
        port = 6889;
        logLevel = "verbose";
      };
      # regular mkShell options
      nativeBuildInputs = [ pkgs.hello ];
      someEnv = "this";
    };
  };
}
