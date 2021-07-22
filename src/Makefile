scf4: boiler
	./boiler --ocaml batteries
	alacritty --hold --command nvim build-inputs.nix

scf5: boiler
	./boiler --haskell lens --python pillow
	alacritty --hold --command nvim build-inputs.nix

scf6: boiler
	./boiler --haskell lens
	alacritty --hold --command nvim build-inputs.nix

boiler: boiler.ml build.ml
	ocamlfind ocamlopt -w "-26" -thread -package unix -linkpkg -o boiler build.ml boiler.ml

clean:
	rm *.o exe boiler build-inputs.nix \
		*.cmi *.cmx \
		*.hi
