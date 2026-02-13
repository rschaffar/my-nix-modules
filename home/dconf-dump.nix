{
  lib,
  pkgs,
  config,
  ...
}:

let
  types = lib.types;
  cfg = config.profiles.dconfDumps;
  needsDbus = ''
    if [[ -v DBUS_SESSION_BUS_ADDRESS ]]; then
      export DCONF_DBUS_RUN_SESSION=""
    else
      export DCONF_DBUS_RUN_SESSION="${pkgs.dbus}/bin/dbus-run-session --dbus-daemon=${pkgs.dbus}/bin/dbus-daemon"
    fi
  '';

  entryType = types.submodule {
    options = {
      name = lib.mkOption {
        type = types.str;
        description = "Activation entry name for this dump.";
      };
      path = lib.mkOption {
        type = types.str;
        example = "/org/gnome/shell/extensions/tilingshell/";
        description = "Dconf path to reset before loading the dump.";
      };
      dumpFile = lib.mkOption {
        type = types.path;
        description = "Path to a dconf dump file.";
      };
      strictReset = lib.mkOption {
        type = types.bool;
        default = true;
        description = "Reset the path before loading the dump to ensure exact state.";
      };
    };
  };
in
{
  options.profiles.dconfDumps = lib.mkOption {
    type = types.listOf entryType;
    default = [ ];
    description = "List of dconf dumps to load during activation.";
  };

  config = lib.mkIf (cfg != [ ]) {
    home.activation = lib.mkMerge (
      map (entry: {
        ${entry.name} = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${needsDbus}
          ${lib.optionalString entry.strictReset "run $DCONF_DBUS_RUN_SESSION ${pkgs.dconf}/bin/dconf reset -f ${entry.path}"}
          run $DCONF_DBUS_RUN_SESSION ${pkgs.dconf}/bin/dconf load ${entry.path} < ${entry.dumpFile}
        '';
      }) cfg
    );
  };
}
