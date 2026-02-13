{
  lib,
  ...
}:
{
  options.mySystem = {
    desktop = lib.mkOption {
      type = lib.types.enum [
        "none"
        "gnome"
      ];
      default = "none";
      description = "Selected system desktop environment/window manager.";
    };

    hasNvidia = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this system has an NVIDIA GPU (enables CUDA-accelerated packages).";
    };
  };
}
