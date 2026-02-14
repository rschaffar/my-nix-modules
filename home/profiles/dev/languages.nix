# Programming languages, compilers, and formatters
{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Java ecosystem
    jdk25
    maven

    # Python ecosystem
    uv
    pyenv
    (python313.withPackages (
      ps: with ps; [
        requests
        beautifulsoup4
        lxml
      ]
    ))

    # JavaScript/Node
    nodejs_22

    # Rust
    rust-analyzer

    # C/C++
    gcc

    # Formatters
    stylua # Lua formatter
  ];

  # JDK symlinks for easy access
  home.activation.jdk25Link = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn ${pkgs.jdk25} "$HOME/jdk25"
  '';

  home.activation.jdk21Link = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn ${pkgs.jdk21} "$HOME/jdk21"
  '';

  home.activation.jdk17Link = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn ${pkgs.jdk17} "$HOME/jdk17"
  '';

  home.activation.jdk11Link = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn ${pkgs.jdk11} "$HOME/jdk11"
  '';
}
