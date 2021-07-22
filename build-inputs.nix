{ pkgs ? import <nixpkgs> { } }:
with pkgs;
(with ocamlPackages; [ findlib utop ]) ++
[ ocaml gnumake ]
