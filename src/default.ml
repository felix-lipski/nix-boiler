let default = "{ pkgs, nixpkgs }:
let
  lib          = nixpkgs.lib;
in
pkgs.pkgs.stdenv.mkDerivation rec {
  pname        = \"%s\";
  version      = \"0.0.0\";
  unpackPhase  = ''
    true
    '';
  buildInputs  = (import ./build-inputs.nix) { inherit pkgs; };

  buildPhase   = ''
    echo \"example file\" > foo.txt
    '';

  # Everything in the $out/ will be available in the package in the store
  installPhase = ''
    mkdir -p $out/bin
    cp foo.txt $out/bin/foo.txt
    '';
}
"

let makefile = "scf4:
	echo \"shortcut F4\"

scf5:
	echo \"shortcut F5\"

clean:
	rm *.o exe \
		# *.cmi *.cmx \
		# *.hi
"

let gen proj_name = 
    let default_oc = open_out (proj_name ^ "/default.nix") in
    let makefile_oc = open_out (proj_name ^ "/Makefile") in
    Printf.fprintf default_oc (Scanf.format_from_string default "%s") proj_name;
    output_string makefile_oc makefile;
    close_out default_oc; 
    close_out makefile_oc; 
