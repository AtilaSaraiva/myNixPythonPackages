self: super:
{
  codepy = super.python3Packages.callPackage ./pkgs/codepy {
    inherit (self.python3Packages) pytools appdirs six cgen;
    inherit (self) fetchFromGitHub;
  };

  contexttimer = super.python3Packages.callPackage ./pkgs/contexttimer {
    inherit (self.python3Packages) mock;
    inherit (self) fetchFromGitHub fetchpatch;
  };
}
