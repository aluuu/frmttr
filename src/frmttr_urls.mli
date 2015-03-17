type ('a, 'b) url =
  | S : string -> ('a, 'a) url
  | Int : ('a, int -> 'a) url
  | String : ('a, string -> 'a) url
  | Compose : ('b, 'c) url * ('a, 'b) url -> ('a, 'c) url

val match_url : ('a, 'b) url -> string -> 'b -> ('a * string) option

val (</>) : ('b, 'c) url -> ('a, 'b) url -> ('a, 'c) url
