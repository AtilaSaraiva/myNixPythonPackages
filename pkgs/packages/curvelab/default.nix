{ lib
, stdenv
, fetchurl
, fftw2
}:

stdenv.mkDerivation rec {
  pname = "curvelab";
  version = "2.1.3";

  src = fetchurl {
    url = "https://archive.org/download/curve-lab-2.1.3.tar/CurveLab-${version}.tar.gz";
    sha256 = "sha256-vShEJ9T+9y3z40jTGgHakq9po0oP3lyWvbFJ/+bWMPc=";
  };

  buildInputs = [ fftw2 ];

  installPhase = ''
    runHook preInstall

    install -Dm755 fdct3d/src/libfdct3d.a $out/lib/fdct3d/src/libfdct3d.a
    install -Dm755 fdct3d_outcore/src/libfdct3d.a $out/lib/fdct3d_outcore/src/libfdct3d.a
    install -Dm755 fdct_usfft_cpp/src/libfdct_usfft.a $out/lib/fdct_usfft_cpp/src/libfdct_usfft.a
    install -Dm755 fdct_wrapping_cpp/src/libfdct_wrapping.a $out/lib/fdct_wrapping_cpp/src/libfdct_wrapping.a

    runHook postInstall
  '';

  meta = with lib; {
    description = "CurveLab is a software library for the curvelet transform";
    homepage = "http://curvelet.org/";
    platforms = platforms.linux;
    license = licenses.unfree;
    maintainers = with maintainers; [ atila ];
  };
}
