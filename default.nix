{ pkgs, nixpkgs }:
let
  lib           = nixpkgs.lib;
in
pkgs.pkgs.stdenv.mkDerivation rec {
  pname       = "nix-boiler";
  version     = "0.0.2";

  src = ./src;

  buildInputs = (import ./build-inputs.nix) { inherit pkgs; };

  buildPhase  = ''
    make main
    '';

  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin/nix-boiler
    '';
}
