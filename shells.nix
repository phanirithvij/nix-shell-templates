{
  sources ? import ./npins,
  pkgs ? import sources.nixpkgs { },
}:
let
  inherit (pkgs) lib;
  shellsConf =
    (import ./modules {
      inherit sources pkgs;
      modules = [ ./devshells.nix ];
    }).config;
  shells = lib.mapAttrs (name: v: v.build) shellsConf.out.devshell.shells;
in
shells
// {
  config = shellsConf;
}
