{ pkgs, nixpkgs }:
let
  lib           = nixpkgs.lib;
in
pkgs.pkgs.stdenv.mkDerivation rec {
  pname       = "boilerplate";
  version     = "0.0.0";
  unpackPhase = ''
    true
    '';
  buildInputs = (import ./build-inputs.nix) { inherit pkgs; };

  buildPhase  = ''
    '';

  installPhase = ''
    mkdir -p $out/bin
    cp ${./flake.nix} $out/bin/flake.nix
    '';
}
