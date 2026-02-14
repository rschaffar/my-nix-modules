# Security and password management applications
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Password managers
    keepassxc
    _1password-gui
    _1password-cli

    # Yubikey tools
    yubioath-flutter

    # GNOME keyring management
    seahorse
  ];
}
