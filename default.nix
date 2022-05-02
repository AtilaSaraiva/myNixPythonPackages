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

  pythonOverrides = python-self: python-super: {
    devito = python-super.devito.overrideAttrs (oldAttrs: {
      src = super.fetchFromGitHub {
        owner = "devitocodes";
        repo = "devito";
        rev = "7cb52eded4038c1a0ee92cfd04d3412c48f2fb7c";
        sha256 = "sha256-75hkkufQK9Nv65DBz8cmYTfkxH/UUWDQK/rGUDULvjM=";
      };
    });
  };

  python3 = super.python3.override { packageOverrides = self.pythonOverrides; };

  curvelab = super.callPackage ./pkgs/packages/curvelab {
    inherit (self) fetchurl;
    fftw2 = self.fftw2;
  };

  fftw2 = super.callPackage ./pkgs/packages/fftw2 {
    inherit (self) fetchurl;
  };
}
