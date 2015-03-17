open Frmttr

let () =
  assert ((sprintf (Lit "s" || Int) 5) = "s5");
  assert ((sprintf (Lit "Some string: " || Float) 5.1) = "Some string: 5.1");
  assert ((sprintf (Lit "Some string: " || Float || Lit ", " || Int) 1.12345 6) = "Some string: 1.12345, 6");
  assert ((sscanf "Hello world" (Lit "Hello world") () = (Some ()) ));
  assert ((sscanf "Hello world: 42;" (Lit "Hello world: " || Int || Lit ";") id = (Some 42) ));
  assert ((sscanf "Hello world: -42.1;" (Lit "Hello world: " || Float || Lit ";") id = (Some (-42.1)) ));
