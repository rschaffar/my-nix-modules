{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.profiles.theme = {
    enable = lib.mkEnableOption "system theme configuration";
  };

  config = lib.mkIf config.profiles.theme.enable {
    home.packages = with pkgs; [
      cantarell-fonts
    ];

    # GTK Theme Configuration
    gtk = {
      enable = true;

      font = {
        name = "Cantarell";
        size = 11;
      };

      # Example to set icon theme
      # iconTheme = {
      #   name = "Papirus";
      #   package = pkgs.papirus-icon-theme;
      # };

      # Example to set cursor theme
      # cursorTheme = {
      #   name = "Bibata-Modern-Ice";
      #   package = pkgs.bibata-cursors;
      # };
    };

    # Qt Theme Configuration
    qt = {
      enable = true;
      platformTheme.name = "gtk"; # Qt apps will try to look like GTK apps
      style.name = "adwaita";
    };
  };
}
