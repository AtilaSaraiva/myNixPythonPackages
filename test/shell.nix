# python.nix
with (import <nixpkgs> { overlays = [ (import ../.) ];});
let
  my-python-packages = python-packages: with python-packages; [
    codepy
    contexttimer
    # other python packages you want
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
mkShell {
  buildInputs = [
    python-with-my-packages
  ];
}

