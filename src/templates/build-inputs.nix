{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  customPython = pkgs.python39.buildEnv.override {
    extraLibs = with pkgs.python39Packages; [
      # Add Python packages here
      pillow
    ];
  };
  customGhc = haskellPackages.ghcWithPackages (pkgs: with pkgs; [
    # Add Haskell packages here
    lens
  ]);
  ocamlPkgs = (with ocamlPackages; [ 
    # Add OCaml packages here
    findlib utop 
  ]);
in
# Add your dependecies to the list below:
[ 
  customPython
  customGhc
  ocaml
] ++ ocamlPkgs
