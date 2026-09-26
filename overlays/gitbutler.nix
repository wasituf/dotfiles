final: prev:

let
  gitbutler-unwrapped = prev.stdenv.mkDerivation {
    pname = "gitbutler-unwrapped";
    version = "unstable";

    src = prev.fetchurl {
      url = "https://app.gitbutler.com/downloads/release/linux/x86_64/deb";
      hash = "sha256-RYP6aVS9myO8bVvna3Yn65SnE8r1ztC5TBtWPujElzw=";
    };

    nativeBuildInputs = [ prev.dpkg ];

    dontUnpack = true;

    installPhase = ''
      mkdir -p "$out"
      dpkg-deb --extract "$src" "$out"

      if [ ! -x "$out/usr/bin/gitbutler-tauri" ]; then
        echo "GitButler executable was not found in the expected Debian layout" >&2
        exit 1
      fi

      if [ ! -x "$out/usr/bin/but" ]; then
        echo "GitButler CLI was not found at /usr/bin/but" >&2
        exit 1
      fi
    '';
  };

  fhsPackages =
    pkgs: with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      cairo
      cups
      dbus
      expat
      gdk-pixbuf
      glib
      gtk3
      libdrm
      libnotify
      libsoup_3
      libxkbcommon
      mesa
      nspr
      nss
      pango
      systemd
      wayland
      webkitgtk_4_1
      libX11
      libXcomposite
      libXdamage
      libXext
      libXfixes
      libXrandr
      libxcb
      zlib
    ];

  gitbutler-run = prev.writeShellScript "gitbutler-run" ''
    # Avoid WebKitGTK's broken DMA-BUF/EGL path on the NVIDIA setup.
    export WEBKIT_DISABLE_DMABUF_RENDERER=1
    export WEBKIT_DISABLE_COMPOSITING_MODE=1
    exec "${gitbutler-unwrapped}/usr/bin/gitbutler-tauri" "$@"
  '';

  gitbutler-fhs = prev.buildFHSEnv {
    name = "gitbutler";
    targetPkgs = fhsPackages;
    runScript = gitbutler-run;

    extraInstallCommands = ''
      if [ -d "${gitbutler-unwrapped}/usr/share/applications" ]; then
        mkdir -p "$out/share"
        cp -a "${gitbutler-unwrapped}/usr/share/applications" "$out/share/"
        substituteInPlace "$out/share/applications/GitButler.desktop" \
          --replace-fail "gitbutler-tauri" "gitbutler"
      fi
      if [ -d "${gitbutler-unwrapped}/usr/share/icons" ]; then
        mkdir -p "$out/share"
        cp -a "${gitbutler-unwrapped}/usr/share/icons" "$out/share/"
      fi
    '';
  };

  gitbutler-cli-fhs = prev.buildFHSEnv {
    name = "but";
    targetPkgs = fhsPackages;
    runScript = "${gitbutler-unwrapped}/usr/bin/but";
  };
in
{
  gitbutler = prev.symlinkJoin {
    name = "gitbutler";
    paths = [
      gitbutler-fhs
      gitbutler-cli-fhs
    ];

    meta = with prev.lib; {
      homepage = "https://gitbutler.com/";
      description = "Git client for simultaneous branches and stacked commits";
      license = licenses.mit;
      mainProgram = "gitbutler";
      platforms = [ "x86_64-linux" ];
    };
  };
}
