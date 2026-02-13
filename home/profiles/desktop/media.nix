# Media creation and playback applications
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.desktop.media.enable =
    lib.mkEnableOption "media creation and playback applications";

  config = lib.mkIf config.profiles.desktop.media.enable {
    home.packages = with pkgs; [
      # Video/streaming
      obs-studio
      vlc

      # Graphics
      gimp
      krita

      # Audio
      audacity
      easyeffects

      # Browsers (beyond Firefox in desktop.core)
      google-chrome
      qutebrowser

      # Music
      pear-desktop # YouTube Music player
      spotify

      # Gaming
      prismlauncher # Minecraft launcher
    ];
  };
}
