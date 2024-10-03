{ lib, ... }:
let
  shellSchema = lib.types.submodule (
    { config, name, ... }:
    {
      options = {
        enable = lib.mkEnableOption "devshell";
        name = lib.mkOption {
          type = lib.types.str;
          default = "${name}-shell";
          description = "devshell name";
        };
        help = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "devshell description";
        };
        packages = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [ ];
        };
        commands = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [ ];
        };
        tools = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [ ];
        };
        /*
          config = lib.mkOption {
            type = lib.types.anything;
            default = { };
            example =
              # nix
              ''
                {
                  name = "TODO";
                }
              '';
          };
        */
        build = lib.mkOption {
          type = lib.types.anything;
          default = import ./devshells.nix {
            inherit (config) tools name packages;
            extraCommands = config.commands;
            enableTreefmt = false;
          };
          readOnly = true;
        };
      };
    }
  );
in
shellSchema
