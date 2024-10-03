{
  sources ? import ../npins,
  pkgs ? import sources.nixpkgs { },
  devshell ? import sources.devshell { nixpkgs = pkgs; },
  treefmt-nix ? import sources.treefmt-nix,

  name ? "nix-shell-templates",
  tools ? [ pkgs.npins ],
  extraCommands ? [ ],
  packages ? [ ],
  enableTreefmt ? true,
  generalCategory ? "[general commands]",
}:
let
  inherit (pkgs) lib;

  mkShellSuggestions =
    {
      shells,
      category ? "shells",
    }:
    lib.attrsets.mapAttrsToList (name: shell: {
      inherit name category;
      inherit (shell) help;
      command = ''$DEVSHELL_DIR/bin/${name}-shell "$@"'';
    }) shells;

  mkOtherShells =
    shells: self:
    lib.filter (v: v != "") (
      lib.attrsets.mapAttrsToList (
        name: shell:
        if name == self then
          ""
        else
          pkgs.writeShellScriptBin "${name}-shell" ''
            if [ $# -eq 0 ]
            then
              nix-shell -A ${name}.shell shells.nix
            else
              nix-shell -A ${name}.shell shells.nix --run "''$@"
            fi
          ''
      ) shells
    );

  mapCmdPackages =
    {
      packages,
      category ? generalCategory,
    }:
    builtins.map (p: {
      package = p;
      inherit category;
    }) packages;

  mapTools =
    packages:
    (mapCmdPackages {
      inherit packages;
      category = "tools";
    });

  mkAliases =
    {
      aliases,
      category ? generalCategory,
    }:
    lib.mapAttrsToList (name: value: {
      command = value;
      help = value;
      inherit name;
    }) aliases;

  treefmtCfg =
    (treefmt-nix.evalModule pkgs (_: {
      projectRootFile = "shell.nix";
      programs.nixfmt.enable = true;
      programs.deadnix.enable = true;
      programs.statix.enable = true;
    })).config.build;

  treefmtCmds = mapCmdPackages {
    packages = (builtins.attrValues treefmtCfg.programs) ++ [ treefmtCfg.wrapper ];
    category = "formatter";
  };

  mkSelfAwareShell =
    args:
    devshell.mkShell (
      args
      // {
        commands = args.commands ++ [
          {
            name = "shell";
            command = ''$DEVSHELL_DIR/bin/${name} "$@"'';
            help = "run any command via the devshell, see shell -h";
          }
        ];
      }
    );

  shellArgs = {
    inherit name packages;
    # only commands show up in menu
    commands = (mapTools tools) ++ extraCommands ++ lib.optional enableTreefmt treefmtCmds;
  };
  _selfshell = mkSelfAwareShell shellArgs;
in
{
  inherit _selfshell;
  devshell = devshell.mkShell shellArgs;
  shell = pkgs.mkShellNoCC {
    shellHook = ''
      source ${_selfshell.hook}/nix-support/setup-hook
    '';
    packages = [ _selfshell ];
  };
  lib = {
    inherit
      mapCmdPackages
      mkAliases
      mapTools
      mkSelfAwareShell
      mkShellSuggestions
      mkOtherShells
      ;
  };
}
