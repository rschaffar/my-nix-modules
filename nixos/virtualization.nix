# Virtualization preset: libvirtd + Docker
{ ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = false;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
    docker.enable = true;
  };
}
