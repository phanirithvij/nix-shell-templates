{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.direnv;
in
{
  options.direnv = {
    enable = lib.mkEnableOption "direnv";
    nix-direnv.enable = lib.mkEnableOption "nix-direnv";
    out = lib.mkOption { type = lib.types.anything; };
  };
  config = lib.mkIf cfg.enable {
    # TODO xdg.configFile like style api to gen outputs for the generated templates?
    # but then the generated template will be in the nix store, readonly?
    # so need a generator which outputs the template instead?
    direnv.out = {
      files = [
        (pkgs.writeText ".envrc" ''
          ${if config.flake.enable then "use flake" else "use nix"}
          ${lib.optionalString cfg.nix-direnv.enable
            # TODO version+hash passed down from inputs?
            # bash
            ''
              # https://github.com/nix-community/nix-direnv#direnv-source_url
              if ! has nix_direnv_version || ! nix_direnv_version 3.0.6; then
                source_url "https://raw.githubusercontent.com/nix-community/nix-direnv/3.0.6/direnvrc" "sha256-RYcUJaRMf8oF5LznDrlCXbkOQrywm0HDv1VjYGaJGdM="
              fi
            ''
          }
        '')
      ];
    };
  };
}
