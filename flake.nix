{
  description = "Reusable NixOS and Home Manager profile modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      # Helper to import a module and make it system-agnostic
      importModule = path: import path;
    in
    {
      # Home Manager modules - import individually or use 'all'
      homeModules = {
        shell = importModule ./home/shell.nix;
        terminal = importModule ./home/terminal.nix;
        dotfiles = importModule ./home/dotfiles.nix;
        git = importModule ./home/git.nix;
        fonts = importModule ./home/fonts.nix;
        theme = importModule ./home/theme.nix;
        app-launchers = importModule ./home/app-launchers.nix;
        dconf-dump = importModule ./home/dconf-dump.nix;
        "profile-cli-core" = importModule ./home/profiles/cli/core.nix;
        "profile-cli-agents" = importModule ./home/profiles/cli/agents.nix;
        "profile-cli-media" = importModule ./home/profiles/cli/media.nix;
        gnome = importModule ./home/gnome.nix;
        yazi = importModule ./home/yazi.nix;
        "profile-dev-languages" = importModule ./home/profiles/dev/languages.nix;
        "profile-dev-cloud" = importModule ./home/profiles/dev/cloud.nix;
        "profile-dev-heavy" = importModule ./home/profiles/dev/heavy.nix;
        "profile-desktop-core" = importModule ./home/profiles/desktop/core.nix;
        "profile-desktop-communication" = importModule ./home/profiles/desktop/communication.nix;
        "profile-desktop-productivity" = importModule ./home/profiles/desktop/productivity.nix;
        "profile-desktop-media" = importModule ./home/profiles/desktop/media.nix;
        "profile-desktop-security" = importModule ./home/profiles/desktop/security.nix;
        all =
          { ... }:
          {
            imports = [
              (importModule ./home/shell.nix)
              (importModule ./home/terminal.nix)
              (importModule ./home/dotfiles.nix)
              (importModule ./home/git.nix)
              (importModule ./home/fonts.nix)
              (importModule ./home/theme.nix)
              (importModule ./home/app-launchers.nix)
              (importModule ./home/dconf-dump.nix)
              (importModule ./home/profiles/cli/core.nix)
              (importModule ./home/profiles/cli/agents.nix)
              (importModule ./home/profiles/cli/media.nix)
              (importModule ./home/gnome.nix)
              (importModule ./home/yazi.nix)
              (importModule ./home/profiles/dev/languages.nix)
              (importModule ./home/profiles/dev/cloud.nix)
              (importModule ./home/profiles/dev/heavy.nix)
              (importModule ./home/profiles/desktop/core.nix)
              (importModule ./home/profiles/desktop/communication.nix)
              (importModule ./home/profiles/desktop/productivity.nix)
              (importModule ./home/profiles/desktop/media.nix)
              (importModule ./home/profiles/desktop/security.nix)
            ];
          };
      };

      # NixOS modules - import individually or use 'all'
      nixosModules = {
        system-options = importModule ./nixos/system-options.nix;
        desktop-base = importModule ./nixos/desktop-base.nix;
        desktop-gnome = importModule ./nixos/desktop-gnome.nix;
        audio = importModule ./nixos/audio.nix;
        virtualization = importModule ./nixos/virtualization.nix;
        locale = importModule ./nixos/locale.nix;
        base = importModule ./nixos/base.nix;
        networking = importModule ./nixos/networking.nix;
        all =
          { ... }:
          {
            imports = [
              (importModule ./nixos/system-options.nix)
              (importModule ./nixos/desktop-base.nix)
              (importModule ./nixos/desktop-gnome.nix)
              (importModule ./nixos/audio.nix)
              (importModule ./nixos/virtualization.nix)
              (importModule ./nixos/locale.nix)
              (importModule ./nixos/base.nix)
              (importModule ./nixos/networking.nix)
            ];
          };
      };
    };
}
