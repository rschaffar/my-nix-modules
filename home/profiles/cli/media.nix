# CLI media tools (exiftool, mediainfo, v4l-utils)
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    exiftool # image/video metadata
    mediainfo # media file information
    v4l-utils # video4linux camera control
  ];
}
