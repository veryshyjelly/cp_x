(* Created by Ayush Biswas at 2026/07/04 22:18 
   https://atcoder.jp/contests/abc130/tasks/abc130_b *)
open Core

let sol n x =
  let l = Array.init n ~f:(fun _ -> Scanf.scanf " %d" Fn.id) in
  let sum = ref 0
  and res = ref 1 in
  for i = 1 to n do
    sum := !sum + l.(i - 1);
    if !sum <= x then incr res
  done;
  printf "%d" !res
;;

let () = Scanf.scanf "%d %d" sol
