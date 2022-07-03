{ lib
, buildPythonPackage
, fetchFromGitHub
, fobis
, fetchpatch
}:

buildPythonPackage rec {
  pname = "sotb-wrapper";
  version = "1.0.1";

  src = fetchFromGitHub {
    #owner = "ofmla";
    #repo = "seiscope_opt_toolbox_w_ctypes";
    #rev = "v${version}";
    #sha256 = "sha256-oGJD9i6Q8M6XGH8N2PhX9Re6m+u+w3FbGMaJl1RLozU=";
    owner = "AtilaSaraiva";
    repo = "seiscope_opt_toolbox_w_ctypes";
    rev = "fix";
    sha256 = "sha256-/+CYHgFSLFWwd0A8Iw1Sx6eE8mrFEQS2pWTK9+2lK94=";
  };

  buildInputs = [ fobis ];

  postPatch = ''
    substituteInPlace setup.py \
    --replace "versioneer.get_version()" "'${version}'" \
    --replace "'cmdclass': versioneer.get_cmdclass()," ""
    cat setup.py
  '';

  preConfigure = ''
    ${fobis}/bin/FoBiS.py build -f seiscope_opt_toolbox_w_ctypes.fobis -mode shared-gnu
  '';
}
