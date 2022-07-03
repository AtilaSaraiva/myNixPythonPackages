self: super:
rec {
  pylops = super.python3Packages.callPackage ./pkgs/python-packages/pylops {
    inherit (self.python3Packages) scipy pyfftw pywavelets numba llvmlite scikit-fmm setuptools-scm;
  };

  sotb-wrapper = super.python3Packages.callPackage ./pkgs/python-packages/sotb-wrapper {
    #inherit (self.python3Packages);
    inherit (self) fetchFromGitHub fobis;
  };

  fobis = super.python3Packages.callPackage ./pkgs/packages/fobis {
    inherit (self.python3Packages) fetchPypi;
  };

  curvelops = super.python3Packages.callPackage ./pkgs/python-packages/curvelops {
    inherit (self.python3Packages) scipy pybind11 pytestCheckHook;
    inherit (self) fetchFromGitHub;
    pylops = self.pylops;
    fftw2 = self.fftw2;
    curvelab = self.curvelab;
  };

  curvelab = super.callPackage ./pkgs/packages/curvelab {
    inherit (self) fetchurl;
    fftw2 = self.fftw2;
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
}
