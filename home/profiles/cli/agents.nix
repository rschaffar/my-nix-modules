# AI coding agents - works everywhere including headless
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.cli.agents = {
    enable = lib.mkEnableOption "AI coding agents (claude-code, codex, gemini-cli)";
  };

  config = lib.mkIf config.profiles.cli.agents.enable {
    home.packages = with pkgs; [
      claude-code
      codex
      gemini-cli
    ];
  };
}
