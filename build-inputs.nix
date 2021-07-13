{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  customPython = pkgs.python39.buildEnv.override {
    # To add python packages add them here   v
    extraLibs = with pkgs.python39Packages; [ ];
  };
in
# Add your dependecies in the list below:
[ ]
