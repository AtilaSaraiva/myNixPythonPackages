self: super:
rec {
  pylops = super.python3Packages.callPackage ./pkgs/python-packages/pylops {
    inherit (self.python3Packages) scipy pyfftw pywavelets numba llvmlite scikit-fmm setuptools-scm;
  };

  tiler = super.python3Packages.callPackage ./pkgs/python-packages/tiler {
    inherit (self.python3Packages) numpy tqdm pytestCheckHook;
  };

  probscale = super.python3Packages.callPackage ./pkgs/python-packages/probscale {
    inherit (self.python3Packages) numpy matplotlib pytestCheckHook;
  };

  temp = super.python3Packages.callPackage ./pkgs/python-packages/temp {
    inherit (self.python3Packages) pytestCheckHook;
  };

  pyevtk = super.python3Packages.callPackage ./pkgs/python-packages/pyevtk {
    inherit (self.python3Packages) pytestCheckHook pytest-cov numpy wheel codecov twine check-manifest readme_renderer black pytest-runner;
  };

  pygeostat = super.python3Packages.callPackage ./pkgs/python-packages/pygeostat {
    inherit (self.python3Packages) pytestCheckHook pyperclip pytest numpy pandas scipy scikit-learn statsmodels numba matplotlib h5py pillow tqdm nbformat nbconvert jupyter-client jupyter;
    inherit (self) probscale pyevtk temp;
  };

  pythonOverrides = python-self: python-super: {
    devito = python-super.devito.overridePythonAttrs (oldAttrs: {
      doCheck = false;
      src = self.fetchFromGitHub {
        owner = "devitocodes";
        repo = "devito";
        rev = "v4.7.1";
        sha256 = "sha256-crKTxlueE8NGjAqu625iFvp35UK2U7+9kl8rpbzf0gs=";
      };
    });
  };

  python3 =
      super.python3.override { packageOverrides = self.pythonOverrides; };

  curvelops = super.python3Packages.callPackage ./pkgs/python-packages/curvelops {
    inherit (self.python3Packages) scipy pybind11 pytestCheckHook;
    inherit (self) fetchFromGitHub;
    pylops = self.pylops;
    fftw2 = self.fftw2;
    curvelab = self.curvelab;
  };

  halide = super.callPackage ./pkgs/packages/halide {
    llvmPackages = self.llvmPackages_12;
    inherit (self) fetchFromGitHub cmake libpng libjpeg mesa eigen openblas lapack blas;
  };

  curvelab = super.callPackage ./pkgs/packages/curvelab {
    inherit (self) fetchurl;
    fftw2 = self.fftw2;
  };

  tapenade = super.callPackage ./pkgs/packages/tapenade {
    inherit (self) fetchurl jdk11 makeWrapper autoPatchelfHook gcc gfortran;
  };

  fortran-fpm = super.callPackage ./pkgs/packages/fpm {
    inherit (self) fetchurl gfortran;
  };

  pyplot-fortran = super.callPackage ./pkgs/packages/pyplot-fortran {
    inherit (self) fetchFromGitHub fortran-fpm;
  };

  fftw2 = super.callPackage ./pkgs/packages/fftw2 {
    inherit (self) fetchurl;
  };

  deepwave = super.python3Packages.callPackage ./pkgs/python-packages/deepwave {
    inherit (self.python3Packages) pytorch pytestCheckHook scipy;
    inherit (self) fetchFromGitHub ninja which;
  };
}
