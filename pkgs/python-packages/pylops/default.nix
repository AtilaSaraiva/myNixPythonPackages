{ lib
, fetchPypi
, buildPythonPackage
, scipy
, pyfftw
, pywavelets
, numba
, llvmlite
, scikit-fmm
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "pylops";
  version = "1.18.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-CNIkXpcOsFnFK+fzef4ufbYsg6JFGIJqUbKoHZg/Ce4=";
  };

  postPatch = ''
    substituteInPlace setup.py --replace "pytest-runner" ""
  '';

  propagatedBuildInputs = [
    scipy
    pyfftw
    pywavelets
    numba
    llvmlite
    scikit-fmm
    setuptools-scm
  ];

  doCheck = false;

  pythonImportsCheck = [ "pylops" ];

  meta = with lib; {
    description = "PyLops – A Linear-Operator Library for Python";
    homepage = "https://github.com/PyLops/pylops";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [ atila ];
  };
}
