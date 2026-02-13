# CLI media tools - metadata inspection and camera control
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.cli.media = {
    enable = lib.mkEnableOption "CLI media tools (exiftool, mediainfo, v4l-utils)";
  };

  config = lib.mkIf config.profiles.cli.media.enable {
    home.packages = with pkgs; [
      exiftool # image/video metadata
      mediainfo # media file information
      v4l-utils # video4linux camera control
    ];
  };
}
