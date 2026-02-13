{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profiles.appLaunchers;

  # Convert "my-app-name" to "My App Name"
  humanize =
    s:
    lib.pipe s [
      (lib.splitString "-")
      (map (
        w:
        let
          first = lib.substring 0 1 w;
          rest = lib.substring 1 (-1) w;
        in
        lib.toUpper first + rest
      ))
      (lib.concatStringsSep " ")
    ];

  mkLauncher =
    name: launcher:
    let
      script = pkgs.writeShellScriptBin "start-${name}" ''
        ${lib.concatMapStringsSep "\n" (app: "${app} &") launcher.apps}
      '';
      desktopItem = pkgs.makeDesktopItem {
        name = "start-${name}";
        desktopName = "Start ${humanize name}";
        comment =
          if launcher.comment != null then
            launcher.comment
          else
            "Launch ${toString (builtins.length launcher.apps)} applications";
        exec = "${script}/bin/start-${name}";
        icon = launcher.icon;
        terminal = false;
        categories = [ "Utility" ];
      };
    in
    {
      inherit script desktopItem;
    };

  launchers = lib.mapAttrs mkLauncher cfg;
in
{
  options.profiles.appLaunchers = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          apps = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "List of application executables to launch";
          };
          comment = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Description shown in desktop entry";
          };
          icon = lib.mkOption {
            type = lib.types.str;
            default = "applications-all";
            description = "Icon name for desktop entry";
          };
        };
      }
    );
    default = { };
    description = "Define app launchers that start multiple applications at once";
  };

  config = lib.mkIf (cfg != { }) {
    home.packages =
      lib.mapAttrsToList (_: l: l.script) launchers ++ lib.mapAttrsToList (_: l: l.desktopItem) launchers;
  };
}
