let () = 
    let langs = Build.langs in
    Build.(
        Arg.parse arg_parser (fun x -> ()) "Generate Nix (+ Flakes) boilerplate.";
        gen_build_inputs langs;
        )
