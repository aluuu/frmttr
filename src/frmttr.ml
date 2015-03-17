(* some helpers *)
let prefixp str = fun inp ->
  if String.length str <= String.length inp &&
     str = String.sub inp 0 (String.length str)
  then Some (String.sub inp (String.length str) (String.length inp - String.length str))
  else None

let intS = fun inp ->
  let n = String.length inp in
  let rec loop acc i =
    if i >= n then Some (acc, "") else
      let c = inp.[i] in
      if c >= '0' && c <= '9' then
        loop (acc * 10 + (int_of_char c - int_of_char '0')) (succ i)
      else if i = 0 then
        None
      else
        Some (acc, String.sub inp i (n-i)) in
  if n = 0 then
    None
  else
    loop 0 0

let floatS = fun inp ->
  let n = String.length inp in
  let rec loop acc i =
    if i >= n then Some (float_of_string acc, "") else
      let c = inp.[i] in
      if (c == '-' && i == 0) || (c >= '0' && c <= '9' || c == '.') then
        loop (String.concat "" [acc; Char.escaped c]) (succ i)
      else if i = 0 then
        None
      else
        Some (float_of_string acc, String.sub inp i (n-i)) in
  if n = 0 then
    None
  else
    loop "" 0

let may : type a b. b -> (a -> b) -> a option -> b = fun n f m ->
  match n, f, m with
  | n, _, None -> n
  | _, f, (Some x) -> f x

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
  | Int, inp, f -> (match intS inp with
    | Some (v, rest) -> Some (f v, rest)
    | None -> None)
  | Float, inp, f -> (match floatS inp with
    | Some (v, rest) -> Some (f v, rest)
    | None -> None)
  | Compose (a, b), inp, f -> may None (fun (vb, inp') -> ints b inp' vb) (ints a inp f)

let (||) a b = Compose (a, b)

let id x = x

let sprintf f = intp f id

let sscanf inp fmt f = may None (fun (x, _) -> Some x) (ints fmt inp f)
