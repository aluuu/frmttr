# frmttr

Playing with GADT in OCaml 4.02.

Repository provides simplified `sprintf` and `sscanf` analogs.

## Example

```ocaml
open Frmttr

let () =
  let fmt = Lit "some string " || Int || Lit " some other string "|| Int in
  let str = sprintf fmt 1 5 in
  assert (str = "some string 1 some other string 5")

let fmt = Lit "some string " || Int in
  let result = sscanf fmt "some string 42" in
  assert (result = Some 42)
```

## References

* [Type-safe functional formatted IO](http://okmij.org/ftp/typed-formatting/)
