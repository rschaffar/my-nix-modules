{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.mySystem.desktop == "gnome") {
    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.displayManager.gdm.autoSuspend = false;
    services.desktopManager.gnome.enable = true;
    services.gnome.gnome-keyring.enable = true;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
      ];
    };
  };
}
