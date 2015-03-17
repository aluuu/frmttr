#!/usr/bin/env ocaml
#directory "pkg";;
#use "topkg.ml";;

let () =
  Pkg.describe
    "frmttr" ~builder:`OCamlbuild
    [
      Pkg.lib "pkg/META";
      Pkg.lib ~exts:Exts.module_library "src/frmttr";
      Pkg.lib ~exts:Exts.module_library "src/frmttr_urls";
      Pkg.bin ~auto:true "test/test";
      Pkg.doc "README.md"
    ]
