open Utils

type ('a, 'b) fmt =
  | Lit : string -> ('a, 'a) fmt
  | Int : ('a, int -> 'a) fmt
  | Float : ('a, float -> 'a) fmt
  | Compose : ('b, 'c) fmt * ('a, 'b) fmt -> ('a, 'c) fmt

let rec intp : type a b. (a, b) fmt -> (string -> a) -> b = fun f k ->
  match f with
  | Lit str -> k str
  | Int -> (fun x -> k (string_of_int x))
  | Float -> (fun x -> k (string_of_float x))
  | Compose (a, b) -> intp a (fun sa -> intp b (fun sb -> k (String.concat "" [sa; sb])))

let rec ints : type a b. (a, b) fmt -> string -> b -> (a * string) option = fun fmt k f  ->
  match fmt, k, f with
  | Lit str, inp, f -> may None (fun inp' -> Some (f, inp')) (prefixp str inp)
  | Int, inp, f -> (match read_int inp with
    | Some (v, rest) -> Some (f v, rest)
    | None -> None)
  | Float, inp, f -> (match read_float inp with
    | Some (v, rest) -> Some (f v, rest)
    | None -> None)
  | Compose (a, b), inp, f -> may None (fun (vb, inp') -> ints b inp' vb) (ints a inp f)

let (||) a b = Compose (a, b)

let id x = x

let sprintf f = intp f id

let sscanf inp fmt f = may None (fun (x, _) -> Some x) (ints fmt inp f)
