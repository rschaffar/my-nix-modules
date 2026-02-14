{
  lib,
  stdenv,
  makeWrapper,
  bash,
  coreutils,
  openssh,
  gnused,
  fzf,
}:

stdenv.mkDerivation {
  pname = "ssh-helpers";
  version = "1.0";

  src = ./src;

  nativeBuildInputs = [ makeWrapper ];

  postPatch = ''
    patchShebangs .
  '';

  installPhase = ''
    mkdir -p $out/bin

    install -m 0755 $src/sshm $out/bin/sshm
    install -m 0755 $src/sshl $out/bin/sshl
    install -m 0755 $src/sshk $out/bin/sshk
    install -m 0755 $src/sshkill $out/bin/sshkill

    wrapProgram $out/bin/sshm \
       --prefix PATH : ${
         lib.makeBinPath [
           bash
           openssh
         ]
       }

    wrapProgram $out/bin/sshl \
       --prefix PATH : ${
         lib.makeBinPath [
           bash
           coreutils
           gnused
         ]
       }

    wrapProgram $out/bin/sshk \
       --prefix PATH : ${
         lib.makeBinPath [
           bash
           coreutils
           gnused
           openssh
         ]
       }

    wrapProgram $out/bin/sshkill \
       --prefix PATH : ${
         lib.makeBinPath [
           bash
           coreutils
           gnused
           openssh
           fzf
         ]
       }
  '';

  meta = {
    description = "SSH master connection management helpers (sshm, sshl, sshk, sshkill)";
    license = lib.licenses.mit;
  };
}
