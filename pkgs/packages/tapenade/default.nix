{ stdenv
, lib
, fetchurl
, jdk11
, makeWrapper
, autoPatchelfHook
, gcc
, gfortran
}:

stdenv.mkDerivation rec {
  pname = "tapenade";
  version = "3.16";

  #src = fetchFromGitLab {
    #owner = pname;
    #repo = pname;
    #rev = version;
    #sha256 = "";
  #};
  src = fetchurl {
    url = "http://www-sop.inria.fr/ecuador/tapenade/distrib/tapenade_${version}.tar";
    sha256 = "sha256-YYL7iRGCiEqUjH0J+SlUafZ5UZ8+C4M7lWf/hjrcWu8=";
  };

  nativeBuildInputs = [ jdk11 autoPatchelfHook makeWrapper ];

  dontConfigure = true;
  dontBuild = true;

  #buildPhase = ''
    #export GRADLE_USER_HOME=$(mktemp -d);
    #./gradlew
  #'';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/build
    mkdir -p $out/resources

    cp -r bin $out/
    cp -r build $out/
    cp -r resources $out/

    for file in $out/bin/tap*
    do
      wrapProgram $file \
        --prefix PATH : ${lib.makeBinPath [ jdk11 gcc gfortran ]} \
        --prefix TAPENADE_HOME : $out
    done

    runHook postInstall
  '';
}
