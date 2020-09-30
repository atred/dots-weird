{ stdenv, fetchurl, gtk-engine-murrine }:

stdenv.mkDerivation rec {
  pname = "gtk-dracula-theme";
  version = "2.0";

  src = fetchurl {
    url = "https://github.com/dracula/gtk/releases/download/v${version}/Dracula.tar.xz";
    # sha256 = "00b8w69xapqy8kc7zqwlfz1xpld6hibbh35djvhcnd905gzzymkd";
  };

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes/Ant-Dracula
    cp -a * $out/share/themes/Ant-Dracula
    rm -r $out/share/themes/Ant-Dracula/{Art,LICENSE,README.md,gtk-2.0/render-assets.sh}
    runHook postInstall
  '';

  # outputHashAlgo = "sha256";
  # outputHashMode = "recursive";
  # outputHash = "084ffv19n8pj7hpzhjv1dqv2hz5rdb6mv3xvficfnqc96dbb29cl";

  meta = with stdenv.lib; {
    description = "A flat and light theme with a modern look";
    homepage = https://github.com/dracula/gtk;
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = [
      maintainers.atred
    ];
  };
}
