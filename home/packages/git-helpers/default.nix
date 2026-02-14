{
  lib,
  stdenv,
  makeWrapper,
  bash,
  git,
}:

stdenv.mkDerivation {
  pname = "git-helpers";
  version = "1.0";

  src = ./src;

  nativeBuildInputs = [ makeWrapper ];

  postPatch = ''
    patchShebangs .
  '';

  installPhase = ''
    mkdir -p $out/bin

    install -m 0755 $src/toggle-github-remote $out/bin/toggle-github-remote
    install -m 0755 $src/git-sign-and-merge $out/bin/git-sign-and-merge

    wrapProgram $out/bin/toggle-github-remote \
       --prefix PATH : ${
         lib.makeBinPath [
           bash
           git
         ]
       }

    wrapProgram $out/bin/git-sign-and-merge \
       --prefix PATH : ${
         lib.makeBinPath [
           bash
           git
         ]
       }
  '';

  meta = {
    description = "Git workflow helpers (remote toggling, signed merges)";
    license = lib.licenses.mit;
  };
}
