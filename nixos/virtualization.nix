{
  pkgs,
  ...
}:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
      };
    };

    spiceUSBRedirection.enable = true;

    docker = {
      enable = true;
    };
  };
}
