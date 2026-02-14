# Git workflow helper tools
#
# Provides:
#   toggle-github-remote - Toggle git remote between HTTPS and SSH GitHub URLs
#   git-sign-and-merge   - Rebase-sign all commits, then create signed merge commit
#
{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ./packages/git-helpers { })
  ];
}
