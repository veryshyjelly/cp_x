module type BASE = sig
  type t

  val empty : t
  val add : t -> int -> t
  val take_exn : t -> t * int
  val find_min : t -> int option
  val find_min_exn : t -> int
end

module Make (H : BASE) = struct
  include H

  type nonrec t =
    { mutable h : t
    ; mutable size : int
    ; mutable sum : int
    }

  let empty = { h = empty; size = 0; sum = 0 }

  let push t x =
    t.h <- add t.h x;
    t.size <- t.size + 1;
    t.sum <- t.sum + x
  ;;

  let pop t =
    let h', x = take_exn t.h in
    t.h <- h';
    t.size <- t.size - 1;
    t.sum <- t.sum - x;
    x
  ;;

  let top t = find_min t.h
  let top_exn t = find_min_exn t.h
end
