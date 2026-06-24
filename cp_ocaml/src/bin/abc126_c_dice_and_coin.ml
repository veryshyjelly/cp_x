(* Created by Ayush Biswas at 2026/06/23 13:02 *)
(* https://atcoder.jp/contests/abc126/tasks/abc126_c *)
open Core

let rec probab d k acc = if d >= k then acc else probab (2 * d) k (acc /. 2.0)

let sol n k =
  List.range ~stop:`inclusive 1 n
  |> List.sum (module Float) ~f:(fun d -> probab d k 1.0)
  |> (fun x -> x /. float_of_int n)
  |> printf "%.12f"
;;

let () = Scanf.scanf "%d %d" sol
