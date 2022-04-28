self: super:
rec {
  codepy = super.python3Packages.callPackage ./pkgs/codepy {
    inherit (self.python3Packages) pytools appdirs six cgen;
    inherit (self) fetchFromGitHub;
  };

  contexttimer = super.python3Packages.callPackage ./pkgs/contexttimer {
    inherit (self.python3Packages) mock;
    inherit (self) fetchFromGitHub fetchpatch;
  };

  pyrevolve = super.python3Packages.callPackage ./pkgs/pyrevolve {
    inherit (self.python3Packages) versioneer cython numpy pytest;
    inherit (self) fetchFromGitHub;
    contexttimer = self.contexttimer;
  };

  devito = super.python3Packages.callPackage ./pkgs/devito {
    inherit (self.python3Packages) anytree nbval sympy scipy cached-property psutil py-cpuinfo cgen click multidict distributed pytestCheckHook matplotlib pytest-xdist;
    inherit (self) fetchFromGitHub;
    pyrevolve = self.pyrevolve;
    codepy = self.codepy;
  };
}
