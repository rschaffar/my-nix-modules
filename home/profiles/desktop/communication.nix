# Communication and messaging apps
{ pkgs, ... }:

{
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
}
