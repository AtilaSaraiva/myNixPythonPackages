{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "temp";
  version = "unstable-2020-12-04";

  src = fetchFromGitHub {
    owner = "andrewp-as-is";
    repo = "temp.py";
    rev = "817e773ce0d607339f8822d16d15d2f88d18e2c2";
    sha256 = "sha256-48ymW7wT7LgE0UxlYpMId10CA4YnD9gQZMSEXsK1WM4=";
  };

  # No tests
  doCheck = false;

  pythonImportsCheck = [ "temp" ];

  meta = with lib; {
    description = "temp.tempdir(), temp.tempfile() functions";
    homepage = "https://github.com/andrewp-as-is/temp.py";
    license = licenses.unlicense;
    maintainers = with maintainers; [ atila ];
  };
}
