# Productivity and office applications
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.desktop.productivity.enable =
    lib.mkEnableOption "productivity and office applications";

  config = lib.mkIf config.profiles.desktop.productivity.enable {
    home.packages =
      with pkgs;
      [
        # Notes and knowledge management
        obsidian
        zotero

        # Office suite
        libreoffice

        # Presentations
        presenterm
        mermaid-cli # diagram generation for presenterm
      ]
      ++ (with pkgs; [
        # Handwriting and annotation
        xournalpp

        # Email
        thunderbird

        # PDF generation for presenterm
        python3Packages.weasyprint

        # Document preparation
        texliveFull
      ]);
  };
}
