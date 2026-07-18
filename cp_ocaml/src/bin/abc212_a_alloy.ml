(* Created by Ayush Biswas at 2026/07/06 13:26 
   https://atcoder.jp/contests/adt_all_20231206_2/tasks/abc212_a *)
open Core

let sol = function
  | _, 0 -> "Gold"
  | 0, _ -> "Silver"
  | _, _ -> "Alloy"
;;

let () = Scanf.scanf "%d %d" (fun a b -> printf "%s" @@ sol (a, b))
