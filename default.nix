{ pkgs, nixpkgs }:
let
  lib           = nixpkgs.lib;
in
pkgs.pkgs.stdenv.mkDerivation rec {
  pname       = "nix-boiler";
  version     = "0.0.1";

  src = ./src;

  # unpackPhase = ''
  #   true
  #   '';

  buildInputs = (import ./build-inputs.nix) { inherit pkgs; };

  buildPhase  = ''
    make boiler
    '';
    # cp -dr ${./src} src
    # ls >> foo.txt
    # cat src/Makefile >> foo.txt
    # ls src >> foo.txt
    # echo "example file" > foo.txt
    # make boiler
    # cp -dr ${./src} src
    # (cd src & make boiler)

  installPhase = ''
    mkdir -p $out/bin
    cp boiler $out/bin/nix-boiler
    '';
    # cp foo.txt $out/bin/foo.txt
    # cp src/boiler $out/bin/nix-boiler
    # mkdir -p $out/bin
    # cp ${./src/weird.ml} $out/bin/weird.ml
}
