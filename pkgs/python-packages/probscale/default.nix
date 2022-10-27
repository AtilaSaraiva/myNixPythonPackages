{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, numpy
, matplotlib
}:

buildPythonPackage rec {
  pname = "probscale";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "matplotlib";
    repo = "mpl-probscale";
    rev = "v${version}";
    sha256 = "sha256-+/Z0sVWnmJ2Hx9bixbGdbdSLpam/AtBJB6J7Exz76pw=";
  };

  propagatedBuildInputs = [ numpy matplotlib ];

  checkInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "probscale" ];

  meta = with lib; {
    description = "Real probability scales for matplotlib";
    homepage = "https://matplotlib.org/mpl-probscale/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ atila ];
  };
}
