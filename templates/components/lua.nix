{ pkgs, ... }:
let
  mainProgram = pkgs.lua;
in
{
  treefmtCfg = {
    programs.stylua.enable = true;
  };
  packages = [ mainProgram ];
  inherit mainProgram;
}
