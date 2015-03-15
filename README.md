# frmttr

Playing with GADT in OCaml 4.02.

Repository provides simplified `sprintf` analog.

## Example

```ocaml
open Frmttr

let () =
  let fmt = Lit "some string " || Int || Lit " some other string "|| Float in
  let str = sprintf fmt 1 5.0123 in
  assert (str = "some string 1 some other string 5.0123")
```

## References

* [Type-safe functional formatted IO](http://okmij.org/ftp/typed-formatting/)
