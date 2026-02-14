# GNOME desktop configuration (extensions and dconf)
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # GNOME Extensions
    gnomeExtensions.system-monitor
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.tiling-shell
    gnomeExtensions.pano
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        # find extensions in gnome using `gnome-extensions list` after adding above and rebuilding
        enabled-extensions = [
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
          "dash-to-dock@micxgx.gmail.com"
          "appindicatorsupport@rgcjonas.gmail.com"
          "tilingshell@ferrarodomenico.com"
          "pano@elhan.io"
          # "highlight-focus@pimsnel.com"
        ];
        disabled-extensions = [ ];
      };
      "org/gnome/desktop/interface".show-battery-percentage = true;
      "org/gnome/desktop/interface".clock-show-seconds = true;
      "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
    };
  };
}
