{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  stdenv,
}:

let
  version = "18.4.4";
in
stdenvNoCC.mkDerivation {
  pname = "omp";
  inherit version;

  src = fetchurl {
    url = "https://github.com/can1357/oh-my-pi/releases/download/v18.4.4/omp-linux-x64";
    hash = "sha256-JMgw/OsL1ohL9b8seit0B7wj+v5lXpJMaV75vjCORvM=";
  };

  licenseFile = fetchurl {
    url = "https://github.com/can1357/oh-my-pi/releases/download/v18.4.4/LICENSE";
    hash = "sha256-FsRfnWZ0QngfA/oZiRTMOavKpI7F7Y9kRkPlVMovv2M=";
  };

  thirdPartyNotices = fetchurl {
    url = "https://github.com/can1357/oh-my-pi/releases/download/v18.4.4/THIRD-PARTY-NOTICES.txt";
    hash = "sha256-0MLnwFu011UESxP6VgvljQGrfJgLh4kkAKl5OX5Wmos=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];

  dontUnpack = true;
  dontStrip = true;

  installPhase = ''
    install -Dm755 "$src" "$out/bin/omp"
    install -Dm644 "$licenseFile" "$out/share/licenses/omp/LICENSE"
    install -Dm644 "$thirdPartyNotices" "$out/share/doc/omp/THIRD-PARTY-NOTICES.txt"
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    "$out/bin/omp" --version
  '';

  meta = {
    description = "Terminal-based coding agent with multi-model support";
    homepage = "https://omp.sh";
    changelog = "https://github.com/can1357/oh-my-pi/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "omp";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
