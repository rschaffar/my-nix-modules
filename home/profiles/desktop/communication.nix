# Communication and messaging apps
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.desktop.communication.enable =
    lib.mkEnableOption "communication and messaging apps";

  config = lib.mkIf config.profiles.desktop.communication.enable {
    home.packages = with pkgs; [
      # Video conferencing
      zoom-us

      # Chat and messaging
      discord
      slack
      element-desktop
      signal-desktop

      # Privacy
      tor-browser
    ];
  };
}
