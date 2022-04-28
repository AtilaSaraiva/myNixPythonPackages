self: super:
{
  codepy = super.python3Packages.callPackage ./pkgs/codepy {
    inherit (self.python3Packages) pytools appdirs six cgen;
    inherit (self) fetchFromGitHub;
  };
}
