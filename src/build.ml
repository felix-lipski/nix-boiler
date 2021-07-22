type lang = {
    name: string;
    build_let: string;
    build: string;
    pkgs: string ref;
}

let ocaml_pkgs   = ref ""
let haskell_pkgs = ref ""
let python_pkgs  = ref ""
let arg_parser = [
    ("--ocaml",   Arg.Set_string ocaml_pkgs,   "List of OCaml packages.");
    ("--haskell", Arg.Set_string haskell_pkgs, "List of Haskell packages.");
    ("--python",  Arg.Set_string python_pkgs,  "List of Ocaml packages.");
]


let ocaml : lang = { 
    name = "ocaml";
    build_let = "  ocamlPkgs = (with ocamlPackages; [ 
    %s
  ]);
"; 
    build = "ocamlPkgs ++ ";
    pkgs = ocaml_pkgs
}


let haskell : lang = { 
    name = "haskell";
    build_let = "  customGhc = haskellPackages.ghcWithPackages (pkgs: with pkgs; [
    %s
  ]);
";
    build = "[ customGhc ] ++ ";
    pkgs = haskell_pkgs
}


let python : lang = { 
    name = "python";
    build_let = "  customPython = pkgs.python39.buildEnv.override {
    extraLibs = with pkgs.python39Packages; [
      %s
    ];
  };
  ";
    build = "[ customPython ] ++ ";
    pkgs = python_pkgs
}


let gen_build_inputs langs = 
    (let oc = open_out "build-inputs.nix" in
    output_string oc "{ pkgs ? import <nixpkgs> { } }:\nwith pkgs;\nlet\n";
    List.iter (fun l ->
        if Array.exists (fun x -> String.equal x ("--" ^ l.name)) Sys.argv
            then Printf.fprintf oc (Scanf.format_from_string l.build_let "%s") !(l.pkgs) else output_string oc "";
    ) langs;
    output_string oc "in\n";
    List.iter (fun l ->
        if Array.exists (fun x -> String.equal x ("--" ^ l.name)) Sys.argv
            then output_string oc (l.build) else ();
    ) langs;
    output_string oc "\n[\n  # Add normal packages here\n]";
    close_out oc; )

let langs = [ocaml; haskell; python]
