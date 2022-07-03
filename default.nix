self: super:
rec {
  pylops = super.python3Packages.callPackage ./pkgs/python-packages/pylops {
    inherit (self.python3Packages) scipy pyfftw pywavelets numba llvmlite scikit-fmm setuptools-scm;
  };

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
