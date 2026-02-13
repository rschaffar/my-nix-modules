{
  lib,
  config,
  pkgs,
  ...
}:

let
  # Pin the upstream plugin repo so our plugin API stays compatible with the
  # Yazi build and the config remains reproducible across machines.
  upstreamPlugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "2301ff803a033cd16d16e62697474d6cb9a94711";
    hash = "sha256-+lirIBXv3EvztE/1b3zHnQ9r5N3VWBCUuH3gZR52fE0=";
  };

  # Start from the nixpkgs plugin set, then override any plugins we want pinned
  # to the upstream repo (e.g., to keep version-sensitive plugins aligned).
  pluginPkg = pkgs.yaziPlugins // {
    zoom = "${upstreamPlugins}/zoom.yazi";
  };
in
{
  options.profiles.yazi.enable = lib.mkEnableOption "yazi file manager";

  # Only enable Yazi when the terminal module is on, so headless/home-minimal
  # profiles do not pull in extra UI/preview dependencies.
  config = lib.mkIf config.profiles.yazi.enable {
    programs.yazi = {
      enable = true;
      # Yazi moves fast; use the unstable channel to keep core features and the
      # plugin API aligned with upstream changes.
      package = pkgs.yazi.override {
        # These are the external helpers Yazi shells out to for previews,
        # archive inspection, and enhanced search/navigation.
        extraPackages = with pkgs; [
          # Archive tooling: used by previewers and extraction flows.
          atool
          bzip2
          gnutar
          gzip
          lz4
          p7zip
          unar
          unrar
          unzip
          xz
          zstd

          # Text/markup preview: syntax highlighting and Markdown rendering.
          bat
          glow

          # Media/image preview: thumbnails, metadata, and terminal rendering.
          chafa
          exiftool
          ffmpegthumbnailer
          imagemagick
          mediainfo
          poppler-utils
          ueberzugpp

          # Type/format detection and structured output.
          file
          jq

          # Search + navigation integrations called by Yazi (fd/rg/fzf/zoxide).
          fd
          fzf
          ripgrep
          zoxide
        ];
      };
      # Provide the shell wrapper that lets Yazi return the last directory on
      # exit; "yy" is short and unlikely to collide with existing aliases.
      shellWrapperName = "yy";
      # Install the wrapper function for each shell we use.
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = {
        # Keep the schema so editors can validate and autocomplete settings.
        "$schema" = "https://yazi-rs.github.io/schemas/yazi.json";
        mgr = {
          # Show dotfiles because we frequently navigate config and repo roots.
          show_hidden = true;
          # Make symlink targets obvious to avoid editing the wrong file.
          show_symlink = true;
          # Natural sort keeps numeric suffixes in human order.
          sort_by = "natural";
          # Directories first reduces friction when traversing trees.
          sort_dir_first = true;
          # Show size and mtime inline to decide quickly without extra panels.
          linemode = "size_and_mtime";
          # [parent, current, preview]; give preview most space by default.
          ratio = [
            1
            3
            4
          ];
          # Keep a few lines of context visible around the cursor.
          scrolloff = 5;
          # Enable basic mouse support for trackpad scrolling and clicks.
          mouse_events = [
            "click"
            "scroll"
          ];
        };
        preview = {
          # Avoid soft-wrapping text previews; horizontal scroll is explicit.
          wrap = "no";
          # Keep large previews bounded so they do not dominate the UI.
          max_width = 600;
          max_height = 900;
          # Lanczos3 yields sharper downscales for image previews.
          image_filter = "lanczos3";
          # JPEG quality keeps previews crisp without huge overhead.
          image_quality = 85;
          # Explicit defaults so HiDPI adjustments are a one-line tweak.
          ueberzug_scale = 1;
          ueberzug_offset = [
            0
            0
            0
            0
          ];
        };
        plugin.prepend_previewers = [
          # Prefer lsar for archive listings (better CJK handling than 7zip).
          {
            mime = "application/{,g}zip";
            run = "lsar";
          }
          # Cover the common compressed tar/7z/rar family with lsar too.
          {
            mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
            run = "lsar";
          }
        ];
        # Blinking cursor makes the input focus obvious in fuzzy prompts.
        input.cursor_blink = true;
      };
      plugins = {
        # One-key open/enter improves muscle memory when browsing.
        "smart-enter" = pluginPkg."smart-enter";
        # Smarter filters speed up narrowing large directories.
        "smart-filter" = pluginPkg."smart-filter";
        # Paste into hovered dir for fewer context switches.
        "smart-paste" = pluginPkg."smart-paste";
        # Quickly hide/maximize panes while respecting ratio defaults.
        "toggle-pane" = pluginPkg."toggle-pane";
        # Cosmetic polish: full border makes pane separation clearer.
        "full-border" = pluginPkg."full-border";
        # Zoom previews for small images (depends on ImageMagick).
        zoom = pluginPkg.zoom;
        # Git linemode makes status visible without extra panes.
        git = pluginPkg.git;
        # VCS change list to jump between modified files.
        "vcs-files" = pluginPkg."vcs-files";
        # Mount/eject workflow without leaving the file manager.
        mount = pluginPkg.mount;
        # Inline diffs for quick compare of two files.
        diff = pluginPkg.diff;
        # Fast chmod on selections without shelling out manually.
        chmod = pluginPkg.chmod;
        # Preview via arbitrary command pipelines.
        piper = pluginPkg.piper;
        # Archive listing fallback (requires unar -> lsar).
        lsar = pluginPkg.lsar;
      };
    };
  };
}
