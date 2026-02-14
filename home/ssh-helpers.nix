# SSH master connection management tools
#
# Provides:
#   sshm    - Create SSH master connection for multiplexing
#   sshl    - List active SSH master connections
#   sshk    - Kill SSH master connections (by name or all)
#   sshkill - Interactive fzf-based master connection killer
#
{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ./packages/ssh-helpers { })
  ];
}
