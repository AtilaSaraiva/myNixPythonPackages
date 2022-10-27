{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pyperclip
, probscale
, pytest
, pyevtk
, numpy
, pandas
, scipy
, scikit-learn
, statsmodels
, numba
, matplotlib
, h5py
, pillow
, tqdm
, nbformat
, nbconvert
, jupyter-client
, jupyter
, temp
}:

buildPythonPackage rec {
  pname = "pygeostat";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "CcgAlberta";
    repo = pname;
    rev = "V_${version}";
    sha256 = "sha256-zCirZ0RIvvo+FSB6DUVKYqiS8OJ7kRhSwqbE8n0JQjQ=";
  };

  postPatch = ''
    substituteInPlace pygeostat/pygeostat_parameters.py \
    --replace "from collections" "from collections.abc"
  '';

  preCheck = ''
    export HOME=$(mktemp -d)
    ls -R
    pwd
  '';

  propagatedBuildInputs = [
    jupyter
    jupyter-client
    pyperclip
    probscale
    pytest
    pyevtk
    numpy
    pandas
    scipy
    scikit-learn
    statsmodels
    numba
    matplotlib
    h5py
    pillow
    tqdm
    nbformat
    nbconvert
    temp
  ];

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    "test_read_csv"
    "test_write_read_gsb"
    "test_gmm_plot"
  ];

  pythonImportsCheck = [ "pygeostat" ];

  meta = with lib; {
    description = "Pygeostat is a Python package for geostatistical modeling";
    homepage = "http://www.ccgalberta.com/pygeostat/index.html";
    license = licenses.mit;
    maintainers = with maintainers; [ atila ];
  };
}
