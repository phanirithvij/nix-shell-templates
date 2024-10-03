{ pkgs, ... }:
let
  mainProgram = pkgs.zig;
in
{
  treefmtCfg = {
    programs.zig.enable = true;
  };
  packages = [
    mainProgram
    pkgs.zls
  ];
  inherit mainProgram;
}
