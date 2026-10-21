open Core

type t =
  { parent : int array
  ; size : int array
  }

let make n = { parent = Array.init n ~f:Fn.id; size = Array.create ~len:n 1 }

let rec find dsu x =
  if dsu.parent.(x) = x
  then x
  else (
    dsu.parent.(x) <- find dsu dsu.parent.(x);
    dsu.parent.(x))
;;

let union dsu a b =
  let a = find dsu a
  and b = find dsu b in
  if a <> b
  then
    if dsu.size.(a) < dsu.size.(b)
    then (
      dsu.parent.(a) <- b;
      dsu.size.(b) <- dsu.size.(a) + dsu.size.(b))
    else (
      dsu.parent.(b) <- a;
      dsu.size.(a) <- dsu.size.(a) + dsu.size.(b))
;;

let same dsu a b = find dsu a = find dsu b
