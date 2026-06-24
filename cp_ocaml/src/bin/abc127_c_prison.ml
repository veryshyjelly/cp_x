(* Created by Ayush Biswas at 2026/06/23 16:53 *)
(* https://atcoder.jp/contests/abc127/tasks/abc127_c *)
open Core

let intersection (a1, b1) = function
  | Some (a2, b2) -> if a1 > b2 || a2 > b1 then None else Some (max a1 a2, min b1 b2)
  | None -> None
;;

let sol n m =
  let sect = ref (Some (Int.min_value, Int.max_value)) in
  for i = 1 to m do
    Scanf.scanf " %d %d" (fun x y -> sect := intersection (x, y) !sect)
  done;
  let res =
    match !sect with
    | None -> 0
    | Some (a, b) -> b - a + 1
  in
  printf "%d" res
;;

let () = Scanf.scanf "%d %d" sol
