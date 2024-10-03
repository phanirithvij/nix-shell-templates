{ lib, ... }@args:
let
  shellSchema = import ../lib/shell-args.nix args;
in
{
  options = {
    out = lib.mkOption {
      type = lib.types.submodule (_: {
        options = {
          devshell = {
            shells = lib.mkOption {
              description = "devshell outputs";
              type = lib.types.attrsOf shellSchema;
              default = { };
              internal = true; # TODO works with and without internal ??
            };
          };
        };
      });
    };
  };
}
