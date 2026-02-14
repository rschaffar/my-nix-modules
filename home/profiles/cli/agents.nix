# AI coding agents (claude-code, codex, gemini-cli)
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    codex
    gemini-cli
  ];
}
