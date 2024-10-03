{ pkgs, ... }:
let
  devshellsLib = (import ./lib/devshells.nix { }).lib;
  commonTools = [
    pkgs.copier
    pkgs.npins
  ];
  commonCmds = devshellsLib.mkAliases {
    aliases = {
      r = "direnv reload";
    };
  };
in
{
  npins.enable = true;

  flake.enable = false;

  direnv.enable = true;
  direnv.nix-direnv.enable = true;

  devshell.enable = true;
  devshell.suggestShells = true;
  devshell.shells.default = {
    help = "minimal shell for this project";
    enable = true;
    tools = commonTools;
    commands = commonCmds;
  };
  devshell.shells.full = {
    help = "full shell with custom devtools";
    enable = true;
    tools = commonTools;
    commands =
      (devshellsLib.mapCmdPackages {
        packages = [
          pkgs.tmuxp
          pkgs.lazygit
        ];
        category = "dev";
      })
      ++ commonCmds;
  };
  treefmt-nix.enable = true;

  dprint.enable = true;

  lang.lua.enable = true;
  lang.go.enable = true;
  lang.zig.enable = true;
  lang.bash.enable = true;
  lang.md.enable = true;
  lang.jsts.enable = true;
  lang.nix = {
    enable = true;
    treefmtCfg = {
      programs.statix.enable = true;
      programs.nixfmt.enable = true;
      programs.nixfmt.package = pkgs.nixfmt-rfc-style;
    };
  };

  lang.py = {
    enable = true;
  };
}
