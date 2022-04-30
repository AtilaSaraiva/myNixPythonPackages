{ lib
, stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  pname = "fftw2";
  version = "2.1.5";

  src = fetchurl {
    url = "ftp://ftp.fftw.org/pub/fftw/fftw-${version}.tar.gz";
    sha256 = "sha256-+AV/rhx9+LmRFng+8+lKakRRjUnHLi5jDCS2icYCJjA=";
  };
}
