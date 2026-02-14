# Base preset: boot, nix settings, shell, system tools
{ pkgs, ... }:
{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  # Nix settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  # Shell
  programs.fish.enable = true;
  programs.command-not-found.enable = false;

  # System tools
  programs.mtr.enable = true;

  # File indexing
  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "daily";
    prunePaths = [
      "/nix/store"
      "/proc"
      "/sys"
      "/run"
      "/tmp"
    ];
  };

  # Do not kill user processes on logout (tmux sessions survive SSH disconnects)
  services.logind.settings.Login.KillUserProcesses = false;
}
