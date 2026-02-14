# Essential CLI tools - works everywhere including headless
{
  pkgs,
  osConfig ? { },
  ...
}:

let
  hasNvidia = builtins.elem "nvidia" (osConfig.services.xserver.videoDrivers or [ ]);
in
{
  home.packages = with pkgs; [
    # Search and navigation
    ripgrep # line-oriented search tool
    ack # grep clone optimized for programmers
    fd # simple, fast and user-friendly alternative to find
    fzf # command-line fuzzy finder
    zoxide # smarter cd command

    # File viewing and processing
    bat # cat clone with syntax highlighting
    delta # syntax-highlighted pager for git
    jq # command-line JSON processor
    jtbl # command-line table processor
    glow # markdown viewer
    file # file type detection utility
    tree # directory tree listing

    # System monitoring and utilities
    (if hasNvidia then btop-cuda else btop) # system monitor
    ncdu # disk usage analyzer
    lsof # list open files
    fastfetch # system information tool

    # Network and transfer
    wget
    inetutils # provides ftp, telnet, etc.
    net-tools # provides netstat, ifconfig, arp, route
    lazyssh # SSH session manager

    # cli fun
    cmatrix # terminal matrix effect
    cava # audio visualizer
    cbonsai # command-line bonsai tree generator
    fortune # displays a random quotation
    nyancat # nyan cat in terminal
    hollywood # Hollywood effect in terminal
    pipes-rs # terminal pipes effect
    lolcat # rainbow coloring for terminal output
    sl # steam locomotive animation

    # Terminal multiplexing
    screen # terminal multiplexer
    tmux-sessionizer # tmux session manager

    # Compression and archiving
    unzip

    # Development utilities
    gh # GitHub CLI
    shellcheck # shell script analysis tool
    direnv # environment variable manager
    openssl # cryptographic library and toolkit

    # Web scraping helpers (CLI)
    htmlq # jq-style HTML queries
    html2text # convert HTML to plaintext
    lynx # terminal browser with dump mode
    w3m # alternate terminal browser

    # Security
    diceware # passphrase generator

    xclip
    wl-clipboard
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        autoFetch = false;
        pagers = [
          {
            colorArg = "always";
            pager = "delta --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
          }
        ];
      };
    };
  };
}
