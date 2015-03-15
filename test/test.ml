open Frmttr

let () =
  assert ((sprintf (Lit "s" || Int) 5) = "s5");
  assert ((sprintf (Lit "some numbers: " || Float || Lit ", " || Int) 1.01 1) = "some numbers: 1.01, 1")
