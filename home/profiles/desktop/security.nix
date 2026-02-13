# Security and password management applications
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.desktop.security.enable =
    lib.mkEnableOption "security and password management applications";

  config = lib.mkIf config.profiles.desktop.security.enable {
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
  };
}
