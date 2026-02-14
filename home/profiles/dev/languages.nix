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

  # JDK symlinks in ~/.jdks/ (IntelliJ's expected location)
  home.activation.jdkLinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.jdks"
    ln -sfn ${pkgs.jdk25} "$HOME/.jdks/jdk25"
    ln -sfn ${pkgs.jdk21} "$HOME/.jdks/jdk21"
    ln -sfn ${pkgs.jdk17} "$HOME/.jdks/jdk17"
    ln -sfn ${pkgs.jdk11} "$HOME/.jdks/jdk11"
  '';
}
