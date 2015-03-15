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

let (||) a b = Compose (a, b)

let id x = x

let sprintf f = intp f id
