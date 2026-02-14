# Heavy development tools (IDEs, containers)
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # IDEs
    jetbrains-toolbox
    vscode-fhs

    # Container management
    lazydocker
  ];
}
