# Essential desktop applications
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.desktop.core.enable = lib.mkEnableOption "essential desktop applications";

  config = lib.mkIf config.profiles.desktop.core.enable {
    programs.firefox.enable = true;

    home.packages =
      with pkgs;
      [
        gnome-tweaks
        # Provide secret-tool for keyring troubleshooting and Secret Service checks
        libsecret
        # Remote desktop clients (RDP/VNC)
        remmina
        freerdp # CLI: xfreerdp /v:host /u:user
      ]
      ++ (with pkgs; [
        evince # PDF viewer
      ]);
  };
}
