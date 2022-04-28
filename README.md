# My nix python packages

Some of this packages are already upstream, but since sometimes the PR review process takes a long time, I will normally implement the derivations here first. Since this is an overlay, the way to use is to include in your overlays.

For instance, you might decide to add to `~/.config/nixpkgs/overlays.nix`:

```nix
[
  (import (builtins.fetchTarball https://github.com/AtilaSaraiva/myNixPythonPackages/archive/main.tar.gz))
]
```

Then install something via `nix-env`:

```sh
$ nix-env -iA nixos.python3Packages.devito
```

However the recommended way to use it the overlay is through a nix-shell derivation. You can check out an example at the [test/shell.nix](test/shell.nix) file.
