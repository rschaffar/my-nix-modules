# Cloud and DevOps tools
{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.profiles.dev.cloud.enable = lib.mkEnableOption "cloud and DevOps tools";

  config = lib.mkIf config.profiles.dev.cloud.enable {
    home.packages =
      with pkgs;
      [
        # AWS
        awscli2
        aws-sso-cli

        # Project management
        jira-cli-go

        # File sync
        rclone
      ]
      ++ (with pkgs; [
        docker-credential-helpers # docker-credential-secretservice for GNOME keyring
      ]);

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
  };
}
