{ pkgs, ... }:
let
  mainProgram = pkgs.python3.withPackages (
    pp: with pp; [
      requests
      tqdm
    ]
  );
in
{
  treefmtCfg = {
    programs.black.enable = true;
  };
  packages = [
    mainProgram
  ];
  inherit mainProgram;
}
