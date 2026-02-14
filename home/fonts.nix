# Nerd Fonts collection
{ pkgs, ... }:

{
  home.packages = [
    pkgs.nerd-fonts.caskaydia-cove
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.fantasque-sans-mono
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.inconsolata
    pkgs.nerd-fonts.iosevka-term
    pkgs.nerd-fonts.iosevka-term-slab
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.meslo-lg
    pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.mononoki
    pkgs.nerd-fonts.sauce-code-pro
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.nerd-fonts.victor-mono
  ];

  fonts.fontconfig.enable = true;
}
