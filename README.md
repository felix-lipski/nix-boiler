# Simple Nix Flake Project Example / Boilerplate

Add your dependencies in `./build-inputs.nix`

Specify how the package should be built in `./default.nix`

Enter your development environment by `nix develop`

Build the package by `nix build`. The `./result` symlink points to a built package.

(This is NOT a list of steps to be performed in order. For example, you do NOT need to be in the development environment to build your package)
