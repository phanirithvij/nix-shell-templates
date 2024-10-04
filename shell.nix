let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
  inherit (pkgs) lib;
  wrapper-manager = import sources.wrapper-manager { inherit lib; };
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    black
    (python3.withPackages (
      py: with py; [
        requests
        tqdm
      ]
    ))
    npins
    nixfmt-rfc-style
  ];
}
