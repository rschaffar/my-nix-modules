# Networking preset: NetworkManager, resolved, SSH, firewall
{ ... }:
{
  # NetworkManager
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };

  # DNS resolution
  services.resolved = {
    enable = true;
    settings.Resolve.FallbackDNS = [
      "8.8.8.8"
      "8.8.4.4"
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
  networking.networkmanager.dns = "systemd-resolved";

  # SSH server (hardened defaults)
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      X11Forwarding = false;
      AllowAgentForwarding = "yes";
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  # Firewall enabled by default
  networking.firewall.enable = true;
}
