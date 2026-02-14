# Locale preset: English (GB), Europe/Vienna timezone, GB keyboard
{ ... }:
{
  time.timeZone = "Europe/Vienna";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = [
    "de_AT.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "en_IE.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_IE.UTF-8"; # Euro currency format regardless of locale
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  console.useXkbConfig = true;
}
