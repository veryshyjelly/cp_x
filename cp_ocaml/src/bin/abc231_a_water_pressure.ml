(* Created by Ayush Biswas at 2026/07/06 13:14 
   https://atcoder.jp/contests/adt_easy_20231206_1/tasks/abc231_a *)
open Core

let sol x =
  let pressure = float x /. 100.0 in
  printf "%f" pressure
;;

let () = Scanf.scanf "%d" sol
