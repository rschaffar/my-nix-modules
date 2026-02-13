{
  lib,
  config,
  ...
}:
let
  cfg = config.mySystem;
in
{
  config = lib.mkMerge [
    # Wayland environment for all desktop hosts
    (lib.mkIf (cfg.desktop != "none") {
      environment.sessionVariables = {
        # Enable native Wayland for Chrome and Electron apps
        NIXOS_OZONE_WL = "1";
      };
    })

    # NVIDIA GPU support
    (lib.mkIf cfg.hasNvidia {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia.open = true;

      environment.sessionVariables = {
        # Required for nvidia-vaapi-driver (hardware video acceleration)
        NVD_BACKEND = "egl";
      };
    })
  ];
}
