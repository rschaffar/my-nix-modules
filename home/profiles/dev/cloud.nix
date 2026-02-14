# Cloud and DevOps tools
{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # AWS
    awscli2
    aws-sso-cli

    # Project management
    jira-cli-go

    # File sync
    rclone

    # Docker credential storage via GNOME keyring
    docker-credential-helpers
  ];

  # Configure docker to use GNOME keyring for credential storage
  home.activation.dockerCredsStore = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.docker"
    config="$HOME/.docker/config.json"
    jq_bin="${pkgs.jq}/bin/jq"

    if [ -e "$config" ] && "$jq_bin" -e . "$config" >/dev/null 2>&1; then
      tmp="$(mktemp "$HOME/.docker/.config.json.tmp.XXXXXX")"
      "$jq_bin" '.credsStore = "secretservice"' "$config" > "$tmp"
      mv "$tmp" "$config"
    else
      printf '%s\n' '{"credsStore":"secretservice"}' > "$config"
    fi

    chmod 600 "$config"
  '';
}
