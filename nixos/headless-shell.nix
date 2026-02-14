# Fish and bash configuration with vim mode for headless instances
#
# Provides a minimal but comfortable shell setup without home-manager.
# - Fish as default shell with vim keybindings
# - Bash available as fallback, also with vim mode
# - Basic aliases
#
{ ... }:
{
  # Fish as default shell with vim mode
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Vim keybindings
      set -g fish_key_bindings fish_vi_key_bindings

      # Show fastfetch on login (skip in tmux/screen or if already shown)
      if test -z "$TMUX" -a -z "$STY" -a -z "$WELCOME_SHOWN"
        set -gx WELCOME_SHOWN 1
        fastfetch
      end
    '';
    shellAliases = {
      ll = "ls -la";
      la = "ls -la";
      l = "ls -l";
    };
  };

  # Bash also available with vim mode
  programs.bash.interactiveShellInit = ''
    set -o vi
  '';
}
