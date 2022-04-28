with import <nixpkgs> {};

( let
    devito = callPackage ./pkgs/devito/default.nix { };
in python39.withPackages (ps:
  [
    ps.numpy
    devito
  ])
).env
