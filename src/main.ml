let () = 
    let langs = Build.langs in
    let out_folder = ref "" in
    Build.(
        Arg.parse arg_parser (fun x -> out_folder := x; ) "Generate Nix (+ Flakes) boilerplate.";
        (* Printf.printf "%s" !out_folder; *)
        (* try Unix.mkdir !out_folder 0o666; with x -> (); *)
        try 
            Sys.mkdir !out_folder 0o777;
            gen_build_inputs !out_folder langs;
            Flake.gen_flake !out_folder;
            Default.gen !out_folder;
        with x -> 
            raise x;
        )
