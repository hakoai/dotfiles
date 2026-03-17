{ pkgs }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "npiperelay-bin";
  version = "0.1.0";

  src = pkgs.fetchzip {
    url = "https://github.com/jstarks/npiperelay/releases/download/v0.1.0/npiperelay_windows_amd64.zip";
    hash = "sha256-GcwreB8BXYGNKJihE2xeelsroy+JFqLK1NK7Ycqxw5g=";
    stripRoot = false;
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp $src/npiperelay.exe $out/bin/npiperelay.exe
    chmod +x $out/bin/npiperelay.exe
    runHook postInstall
  '';
}
