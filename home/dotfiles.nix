{ lib, config, ... }:

let
  cfg = config.profiles.dotfiles;
in
{
  options.profiles.dotfiles = {
    enable = lib.mkEnableOption "dotfiles profile (starship, ideavimrc, tms)";
  };

  config = lib.mkIf cfg.enable {
    # Configuration files
    home.file = {
      ".config/starship.toml".source = ./dotfiles/_config/starship.toml;
      ".config/tms/config.toml".source = ./dotfiles/_config/tms/config.toml;
      ".ideavimrc".source = ./dotfiles/_ideavimrc;
    };
  };
}
