# Shell preset: bash, fish, starship, SSH client config
{ ... }:
let
  # Welcome message script for fish (fastfetch + tailscale status)
  welcomeScript = ''
    # Show welcome message only in login shells or first interactive shell
    # Skip if inside tmux/screen or if WELCOME_SHOWN is set
    if test -z "$TMUX" -a -z "$STY" -a -z "$WELCOME_SHOWN"
      set -gx WELCOME_SHOWN 1
      if command -v fastfetch > /dev/null 2>&1
        fastfetch
      end
      if command -v tailscale > /dev/null 2>&1
        echo ""
        set_color --bold cyan
        # echo "Tailscale status:"
        # set_color normal
        # tailscale status 2>/dev/null || echo "  (not connected)"
      end
      echo ""
    end
  '';
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      # Enable vim/vi-style motions in bash
      set -o vi

      # tmux-sessionizer (tms) completion
      if command -v tms >/dev/null 2>&1; then
        source <(COMPLETE=bash tms)
      fi

      # Refresh SSH_AUTH_SOCK from tmux environment
      tmux-ssh() {
        export $(tmux show-environment | grep SSH_AUTH_SOCK)
      }

      # Switch to GCR ssh-agent (FIDO2 keys with GNOME integration)
      ssh-fido() {
        export SSH_AUTH_SOCK="''${XDG_RUNTIME_DIR}/gcr/ssh"
        echo "SSH_AUTH_SOCK -> gcr-ssh-agent (FIDO2)"
        ssh-add -l 2>/dev/null || echo "  (no keys loaded - run: ssh-fido-load)"
      }

      # Switch to gpg-agent (GPG keys on Yubikey)
      ssh-gpg() {
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        echo "SSH_AUTH_SOCK -> gpg-agent (GPG)"
        ssh-add -l 2>/dev/null || echo "  (no keys or agent unavailable)"
      }

      # Load FIDO2 resident keys from Yubikey into ssh-agent
      ssh-fido-load() {
        ssh-add -K
      }
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Enable vim/vi-style motions in fish
      set -g fish_key_bindings fish_vi_key_bindings

      # tmux-sessionizer (tms) completion
      if command -v tms > /dev/null 2>&1
        COMPLETE=fish tms | source
      end

      # Refresh SSH_AUTH_SOCK from tmux environment
      function tmux-ssh
        set -gx SSH_AUTH_SOCK (tmux show-environment SSH_AUTH_SOCK | string split '=')[2]
      end

      # Switch to GCR ssh-agent (FIDO2 keys with GNOME integration)
      function ssh-fido
        set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gcr/ssh"
        echo "SSH_AUTH_SOCK -> gcr-ssh-agent (FIDO2)"
        ssh-add -l 2>/dev/null; or echo "  (no keys loaded - run: ssh-fido-load)"
      end

      # Switch to gpg-agent (GPG keys on Yubikey)
      function ssh-gpg
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        echo "SSH_AUTH_SOCK -> gpg-agent (GPG)"
        ssh-add -l 2>/dev/null; or echo "  (no keys or agent unavailable)"
      end

      # Load FIDO2 resident keys from Yubikey into ssh-agent
      function ssh-fido-load
        ssh-add -K
      end
    ''
    + welcomeScript;
    shellAliases = {
      ll = "ls -la";
      la = "ls -la";
      l = "ls -l";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      # Don't create masters by default, but reuse if one exists
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%h:%p";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    HISTSIZE = "10000";
    HISTFILESIZE = "20000";
  };
}
