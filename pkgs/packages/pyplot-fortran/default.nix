{ stdenv
, lib
, fetchFromGitHub
, fortran-fpm
}:

stdenv.mkDerivation rec {
  pname = "pyplot-fortran";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "jacobwilliams";
    repo = "pyplot-fortran";
    rev = version;
    sha256 = "sha256-yMYO4gGlUzioOu1BNisHmxOspnj6wPFy0JE1g0He8/s=";
  };

  nativeBuildInputs = [ fortran-fpm ];

  installPhase = ''
    runHook preInstall

    fpm install --prefix $out

    runHook postInstall
  '';
}
