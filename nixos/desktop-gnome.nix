# Desktop preset: GNOME with Wayland
{ pkgs, ... }:
{
  # Enable native Wayland for Chrome and Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # GNOME Desktop Environment
  services.xserver.enable = true;
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
}
