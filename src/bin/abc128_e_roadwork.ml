(* Created by Ayush Biswas at 2026/06/24 23:00
https://atcoder.jp/contests/abc128/tasks/abc128_e *)
open Core

let apply (t, op, x) set =
  match op with
  | 1 -> set := Set.add !set x
  | -1 -> set := Set.remove !set x
  | _ -> assert false
;;

let get_time (t, _, _) = t

let sol n q =
  let events = Array.create ~len:(2 * n) (0, 0, 0) in
  for i = 0 to n - 1 do
    Scanf.scanf " %d %d %d" (fun s t x ->
      events.(2 * i) <- s - x, 1, x;
      events.((2 * i) + 1) <- t - x, -1, x)
  done;
  Array.stable_sort events ~compare:(Comparable.lift Int.compare ~f:get_time);
  let set = ref @@ Set.empty (module Int)
  and pos = ref 0 in
  for _ = 1 to q do
    let d = Scanf.scanf " %d" Fn.id in
    while !pos < 2 * n && get_time events.(!pos) <= d do
      apply events.(!pos) set;
      incr pos
    done;
    match Set.min_elt !set with
    | Some x -> printf "%d\n" x
    | None -> printf "-1\n"
  done
;;

let () = Scanf.scanf "%d %d" sol
