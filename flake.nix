{
  description = "Reusable NixOS and Home Manager preset modules";

  inputs = {
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      flake = true;
    };
  };

  outputs =
    { lanzaboote, ... }:
    {
      # Home Manager modules - import what you need per user
      homeModules = {
        # Shell and terminal
        shell = ./home/shell.nix;
        terminal = ./home/terminal.nix;
        dotfiles = ./home/dotfiles.nix;

        # Git (has options: userName, userEmail, signingKey, extraConfig)
        git = ./home/git.nix;

        # Appearance
        fonts = ./home/fonts.nix;
        theme = ./home/theme.nix;
        gnome = ./home/gnome.nix;

        # Utilities (have options: data-driven, always importable)
        app-launchers = ./home/app-launchers.nix;
        dconf-dump = ./home/dconf-dump.nix;

        # File manager
        yazi = ./home/yazi.nix;

        # CLI tools
        cli-core = ./home/profiles/cli/core.nix;
        cli-agents = ./home/profiles/cli/agents.nix;
        cli-media = ./home/profiles/cli/media.nix;

        # Development
        dev-languages = ./home/profiles/dev/languages.nix;
        dev-cloud = ./home/profiles/dev/cloud.nix;
        dev-heavy = ./home/profiles/dev/heavy.nix;

        # Desktop applications
        desktop-core = ./home/profiles/desktop/core.nix;
        desktop-communication = ./home/profiles/desktop/communication.nix;
        desktop-productivity = ./home/profiles/desktop/productivity.nix;
        desktop-media = ./home/profiles/desktop/media.nix;
        desktop-security = ./home/profiles/desktop/security.nix;
      };

      # NixOS modules - import what you need per host
      nixosModules = {
        # Bootloader (pick one)
        bootloader-systemd-boot = ./nixos/bootloader-systemd-boot.nix;
        bootloader-secure-boot = {
          imports = [
            lanzaboote.nixosModules.lanzaboote
            ./nixos/bootloader-secure-boot.nix
          ];
        };

        desktop-gnome = ./nixos/desktop-gnome.nix;
        nvidia = ./nixos/nvidia.nix;
        audio = ./nixos/audio.nix;
        virtualization = ./nixos/virtualization.nix;
        locale-en-gb = ./nixos/locale-en-gb.nix;
        base = ./nixos/base.nix;
        networking = ./nixos/networking.nix;
      };
    };
}
