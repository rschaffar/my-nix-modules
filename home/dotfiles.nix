# Dotfiles (starship, ideavimrc, tms)
{ ... }:

{
  # Configuration files
  home.file = {
    ".config/starship.toml".source = ./dotfiles/_config/starship.toml;
    ".config/tms/config.toml".source = ./dotfiles/_config/tms/config.toml;
    ".ideavimrc".source = ./dotfiles/_ideavimrc;
  };
}
