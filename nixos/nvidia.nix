# Hardware preset: NVIDIA GPU support
{ ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  # Required for nvidia-vaapi-driver (hardware video acceleration)
  environment.sessionVariables.NVD_BACKEND = "egl";
}
