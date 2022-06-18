{ lib
, buildPythonPackage
, fetchFromGitHub
, pytorch
, ninja
, scipy
, which
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "deepwave";
  version = "0.0.11";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ar4";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-d4EahmzHACHaeKoNZy63OKwWZdlHbUydrbr4fD43X8s=";
  };

  # unable to find ninja although it is available
  postPatch = ''
    substituteInPlace setup.cfg --replace "ninja" ""
  '';

  # The source files are compiled at runtime and cached at the
  # $HOME/.cache folder, so for the check phase it is needed to
  # have a temporary home
  preBuild = ''
    export HOME=$(mktemp -d)
  '';

  propagatedBuildInputs = [ pytorch ];

  checkInputs = [
    ninja
    which
    scipy
    pytestCheckHook
  ];

  pythonImportsCheck = [ "deepwave" ];

  doCheck = false;

  meta = with lib; {
    description = "Wave propagation modules for PyTorch";
    homepage = "https://github.com/ar4/deepwave";
    license = licenses.mit;
    maintainers = with maintainers; [ atila ];
  };
}
