scf4: main
	./main project
	# ./main project --ocaml batteries
	# alacritty --hold --command nvim build-inputs.nix

scf5: main
	./main --haskell lens --python pillow
	alacritty --hold --command nvim build-inputs.nix

scf6: main
	./main --haskell lens
	alacritty --hold --command nvim build-inputs.nix

main: main.ml build.ml flake.ml default.ml
	ocamlfind ocamlopt -w "-26" -thread -package unix -linkpkg -o main flake.ml default.ml build.ml main.ml

clean:
	rm *.o exe main build-inputs.nix \
		*.cmi *.cmx \
		*.hi ;
	rm -drf project
