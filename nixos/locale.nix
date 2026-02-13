{ lib, config, ... }:

let
  cfg = config.mySystem.locale;
in
{
  options.mySystem.locale = {
    timezone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Vienna";
      description = "System timezone.";
    };
    defaultLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_GB.UTF-8";
      description = "Default system locale.";
    };
    supportedLocales = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "de_AT.UTF-8/UTF-8"
        "de_DE.UTF-8/UTF-8"
        "en_GB.UTF-8/UTF-8"
        "en_IE.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
      description = "List of supported locales.";
    };
    xkbLayout = lib.mkOption {
      type = lib.types.str;
      default = "gb";
      description = "X keyboard layout.";
    };
  };

  config = {
    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.defaultLocale;
    i18n.supportedLocales = cfg.supportedLocales;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = cfg.defaultLocale;
      LC_IDENTIFICATION = cfg.defaultLocale;
      LC_MEASUREMENT = cfg.defaultLocale;
      LC_MONETARY = "en_IE.UTF-8"; # Euro currency format regardless of locale
      LC_NAME = cfg.defaultLocale;
      LC_NUMERIC = cfg.defaultLocale;
      LC_PAPER = cfg.defaultLocale;
      LC_TELEPHONE = cfg.defaultLocale;
      LC_TIME = cfg.defaultLocale;
    };
    services.xserver.xkb = {
      layout = cfg.xkbLayout;
      variant = "";
    };
    console.useXkbConfig = true;
  };
}
