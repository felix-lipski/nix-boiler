let flake_nix = "{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, self, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
      let 
        pkgs = import nixpkgs {
          config = { allowUnfree = false; };
          inherit system;
        };
      in {
        devShell =
          pkgs.mkShell {
            buildInputs = (import ./build-inputs.nix) { inherit pkgs; };
          };
        defaultPackage = import ./default.nix { inherit nixpkgs pkgs; };
        }
      );
}
"

let flake_lock = "{
  \"nodes\": {
    \"flake-utils\": {
      \"locked\": {
        \"lastModified\": 1622445595,
        \"narHash\": \"sha256-m+JRe6Wc5OZ/mKw2bB3+Tl0ZbtyxxxfnAWln8Q5qs+Y=\",
        \"owner\": \"numtide\",
        \"repo\": \"flake-utils\",
        \"rev\": \"7d706970d94bc5559077eb1a6600afddcd25a7c8\",
        \"type\": \"github\"
      },
      \"original\": {
        \"owner\": \"numtide\",
        \"repo\": \"flake-utils\",
        \"type\": \"github\"
      }
    },
    \"nixpkgs\": {
      \"locked\": {
        \"lastModified\": 1635405685,
        \"narHash\": \"sha256-S7QGJFLHmUzbefmeje+1pSuzOg7rXIG5oKiXImkA3x8=\",
        \"owner\": \"NixOS\",
        \"repo\": \"nixpkgs\",
        \"rev\": \"19b87ec97df2819e4f4862d1c7521a4fec2e20fc\",
        \"type\": \"github\"
      },
      \"original\": {
        \"owner\": \"NixOS\",
        \"repo\": \"nixpkgs\",
        \"type\": \"github\"
      }
    },
    \"root\": {
      \"inputs\": {
        \"flake-utils\": \"flake-utils\",
        \"nixpkgs\": \"nixpkgs\"
      }
    }
  },
  \"root\": \"root\",
  \"version\": 7
}
"

let gen_flake out_folder = 
    let flake_nix_oc = open_out (out_folder ^ "/flake.nix") in
    let flake_lock_oc = open_out (out_folder ^ "/flake.lock") in
    output_string flake_nix_oc flake_nix;
    output_string flake_lock_oc flake_lock;
    close_out flake_nix_oc; 
    close_out flake_lock_oc; 
