{ lib
, buildPythonPackage
, fetchFromGitHub
, pybind11
, scipy
, pylops
, fftw2
, curvelab
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "curvelops";
  version = "0.11";

  src = fetchFromGitHub {
    owner = "PyLops";
    repo = pname;
    rev = version;
    sha256 = "sha256-ufUZbS+a6tR8Qc6t5KNlynUyooyYqLh1bFcuQwlztw8=";
  };

  postPatch = ''
    substituteInPlace setup.py \
    --replace "include_dirs=[os.path.join(FFTW, 'fftw')" "include_dirs=[os.path.join(FFTW, 'include')" \
    --replace "FFTW, 'fftw', '.libs'" "FFTW, 'lib'"
  '';

  preConfigure = ''
    export FFTW=${fftw2}
    export FDCT=${curvelab}/lib
  '';

  nativeBuildInputs = [ pybind11 ];
  propagatedBuildInputs = [ scipy pylops ];
  checkInputs = [ pytestCheckHook ];

  doCheck = false;

  pythonImportsCheck = [ "curvelops" ];

  meta = with lib; {
    description = "Python wrapper for CurveLab's 2D and 3D curvelet transforms";
    homepage = "https://github.com/PyLops/curvelops";
    license = licenses.mit;
    maintainers = with maintainers; [ atila ];
  };
}
