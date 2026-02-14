{ ... }:
{
  # Enable ARM64 emulation for cross-compilation
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.settings = {
    # Enable cross-compilation for building ARM images
    extra-platforms = [ "aarch64-linux" ];
    system-features = [
      "benchmark"
      "big-parallel"
      "kvm"
      "nixos-test"
      "aarch64-linux"
    ];
  };
}
