{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pytest-cov
, numpy
, wheel
, codecov
, twine
, check-manifest
, readme_renderer
, black
, pytest-runner
}:

buildPythonPackage rec {
  pname = "pyevtk";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "pyscience-projects";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-HrodoVxjREZiutgRJ3ZUrART29+gAZfpR9f4A4SRh4Q=";
  };

  propagatedBuildInputs = [
    numpy
    wheel
    twine
    check-manifest
    readme_renderer
    black
  ];

  checkInputs = [
    pytestCheckHook
    codecov
    pytest-cov
    pytest-runner
  ];

  pythonImportsCheck = [ "pyevtk" ];
}
