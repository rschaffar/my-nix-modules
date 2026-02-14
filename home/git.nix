{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.profiles.git;
  userName = if cfg.userName != null then cfg.userName else config.home.username;

  defaultExtraConfig = {
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
    credential."https://github.com".helper = [
      ""
      "!gh auth git-credential"
    ];
    credential."https://gist.github.com".helper = [
      ""
      "!gh auth git-credential"
    ];
  };
in
{
  options.profiles.git = {
    userName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Git user.name; defaults to home.username when unset.";
    };
    userEmail = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Git user.email; leave null to omit.";
    };
    signingKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "GPG signing key to use for Git commits.";
    };
    extraConfig = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Additional gitconfig entries merged with the defaults.";
    };
  };

  config = {
    programs.git = {
      enable = true;
      package = pkgs.git;
      settings = lib.recursiveUpdate defaultExtraConfig cfg.extraConfig // {
        user = {
          name = userName;
        }
        // lib.optionalAttrs (cfg.userEmail != null) {
          email = cfg.userEmail;
        };
      };
    }
    // lib.optionalAttrs (cfg.signingKey != null) {
      signing = {
        key = cfg.signingKey;
        signByDefault = true;
      };
    };

    home.activation.checkGitConfig = ''
      if [ -f "$HOME/.gitconfig" ]; then
        echo "WARNING: $HOME/.gitconfig exists and will override Home Manager git configuration!"
        echo "Consider removing it to use Home Manager's configuration at $HOME/.config/git/config"
      fi
    '';
  };
}
