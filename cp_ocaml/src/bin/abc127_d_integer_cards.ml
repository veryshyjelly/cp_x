(* Created by Ayush Biswas at 2026/06/23 21:13 *)
(* https://atcoder.jp/contests/abc127/tasks/abc127_d *)
open Core

let sol n m =
  let a = Array.init n ~f:(fun _ -> Scanf.scanf " %d" Fn.id) in
  let ops = Array.init m ~f:(fun _ -> Scanf.scanf " %d %d" (fun b c -> b, c)) in
  Array.sort a ~compare:Int.compare;
  Array.sort ops ~compare:(fun (_, c1) (_, c2) -> Int.descending c1 c2);
  let pos = ref 0 in
  Array.iter ops ~f:(fun (b, c) ->
    let remaining = ref b in
    while !remaining > 0 && !pos < n && a.(!pos) < c do
      a.(!pos) <- c;
      incr pos;
      decr remaining
    done);
  let res = Array.sum (module Int) ~f:Fn.id a in
  printf "%d" res
;;

let () = Scanf.scanf "%d %d" sol
