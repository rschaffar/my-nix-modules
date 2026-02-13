# Heavy development tools - large downloads, full workstations only
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.dev.heavy.enable = lib.mkEnableOption "heavy development tools (IDEs, containers)";

  config = lib.mkIf config.profiles.dev.heavy.enable {
    home.packages = with pkgs; [
      # IDEs
      jetbrains-toolbox
      vscode-fhs

      # Container management
      lazydocker
    ];
  };
}
