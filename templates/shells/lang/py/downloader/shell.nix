let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
  treefmt-nix = import sources.treefmt-nix;

  treefmtCfg = (treefmt-nix.evalModule pkgs (import ./treefmt.nix { inherit pkgs; })).config.build;
  treefmtCmds = (builtins.attrValues treefmtCfg.programs) ++ [
    treefmtCfg.wrapper
  ];
in
pkgs.mkShellNoCC {
  packages =
    with pkgs;
    [
      (python3.withPackages (
        py: with py; [
          requests
          tqdm
        ]
      ))
      npins
    ]
    ++ treefmtCmds;
}
