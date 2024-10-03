{ lib, config, ... }:
let
  cfg = config.npins;
in
{
  options.npins = {
    enable = lib.mkEnableOption "npins";
  };
  config = lib.mkIf cfg.enable {
    # TODO do I gen nix expressions?
    # or do I use this as a library?
    # generating nix expressions seems difficult
    # using as library seems dull, generating nix exprs feels cooler
    # Do I use some magic to run commands like npins init, npins add etc?
    # is this an ansible like thing?
    npins = { };
  };
}
