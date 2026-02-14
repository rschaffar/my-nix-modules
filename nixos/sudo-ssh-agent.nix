{
  ...
}:
{
  # Require SSH agent-based auth for sudo (works with agent forwarding).
  # Uses pam_rssh which supports ED25519-SK (FIDO2) keys.
  # Authorized keys are read from /etc/ssh/authorized_keys.d/<user>

  security.pam.rssh = {
    enable = true;
    settings = {
      auth_key_file = "/etc/ssh/authorized_keys.d/$user";
      cue = true;
    };
  };

  security.pam.services.sudo.rssh = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
