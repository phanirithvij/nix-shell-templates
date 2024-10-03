{ pkgs, ... }:
let
  mainProgram = pkgs.go;
in
{
  treefmtCfg = {
    programs.gofumpt.enable = true;
    programs.golines.enable = true;
  };
  packages = [
    mainProgram
    pkgs.golangci-lint
  ];
  inherit mainProgram;
}
