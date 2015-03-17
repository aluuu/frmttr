open Utils

type ('a, 'b) url =
  | S : string -> ('a, 'a) url
  | Int : ('a, int -> 'a) url
  | String : ('a, string -> 'a) url
  | Compose : ('b, 'c) url * ('a, 'b) url -> ('a, 'c) url

let rec ints : type a b. (a, b) url -> string -> b -> (a * string) option = fun url k f  ->
  match url, k, f with
  | S str, inp, f -> may None (fun inp' -> Some (f, inp')) (prefixp str inp)
  | Int, inp, f -> (match read_int inp with
    | Some (v, rest) -> Some (f v, rest)
    | None -> None)
  | String, inp, f -> (match read_string_until inp '/' with
    | Some (v, rest) -> Some (f v, rest)
    | None -> None)
  | Compose (a, b), inp, f -> may None (fun (vb, inp') -> ints b inp' vb) (ints a inp f)

let (</>) a b = Compose (a, b)
