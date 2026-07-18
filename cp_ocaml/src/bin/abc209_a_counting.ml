(* Created by Ayush Biswas at 2026/07/06 13:17 
   https://atcoder.jp/contests/abc209/tasks/abc209_a *)
open Core

let sol a b =
  let res = b - a + 1 in
  printf "%d" @@ max res 0
;;

let () = Scanf.scanf "%d %d" sol
