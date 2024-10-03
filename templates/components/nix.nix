{ pkgs, ... }:
let
  mainProgram = pkgs.nix;
in
{
  treefmtCfg = {
    programs.nixfmt.enable = true;
    programs.deadnix.enable = true;
    programs.statix.enable = true;
  };
  packages = [ ];
  inherit mainProgram;
}
