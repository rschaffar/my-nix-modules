# Preset: Lanzaboote Secure Boot
{ ... }:
{
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
