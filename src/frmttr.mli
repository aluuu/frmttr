type ('a, 'b) fmt =
  | Lit : string -> ('a, 'a) fmt
  | Int : ('a, int -> 'a) fmt
  | Float : ('a, float -> 'a) fmt
  | Compose : ('b, 'c) fmt * ('a, 'b) fmt -> ('a, 'c) fmt

val intp : ('a, 'b) fmt -> (string -> 'a) -> 'b

val ints : ('a, 'b) fmt -> string -> 'b -> ('a * string) option

val (||) : ('b, 'c) fmt -> ('a, 'b) fmt -> ('a, 'c) fmt

val id : 'a -> 'a

val sprintf : (string, 'b) fmt -> 'b

val sscanf : string -> ('a, 'b) fmt -> 'b -> 'a option
