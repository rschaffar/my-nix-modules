# Productivity and office applications
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Notes and knowledge management
    obsidian
    zotero

    # Office suite
    libreoffice

    # Presentations
    presenterm
    mermaid-cli # diagram generation for presenterm

    # Handwriting and annotation
    xournalpp

    # Email
    thunderbird

    # PDF generation for presenterm
    python3Packages.weasyprint

    # Document preparation
    texliveFull
  ];
}
