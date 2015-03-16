open Frmttr

let () =
  assert ((sprintf (Lit "s" || Int) 5) = "s5");
  assert ((sscanf "Hello world" (Lit "Hello world") () = (Some ()) ));
  assert ((sscanf "Hello world: 42;" (Lit "Hello world: " || Int || Lit ";") id = (Some 42) ));
