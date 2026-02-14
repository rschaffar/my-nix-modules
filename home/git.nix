{ lib, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core = {
        autocrlf = "input";
        pager = "delta";
      };
      interactive.diffFilter = "delta --color-only";
      delta = {
        "side-by-side" = true;
        "line-numbers" = true;
        navigate = true;
        dark = true;
      };
      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
      };
      pull.rebase = true;
    };
  };

  home.activation.checkGitConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -f "$HOME/.gitconfig" ]; then
      echo "WARNING: $HOME/.gitconfig exists and will override Home Manager git configuration!"
      echo "Consider removing it to use Home Manager's configuration at $HOME/.config/git/config"
    fi
  '';
}
