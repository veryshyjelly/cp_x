(* Created by Ayush Biswas at 2026/06/23 14:05 *)
(* https://atcoder.jp/contests/abc126/tasks/abc126_e *)
open Core
open Lib

let sol n m =
  let dsu = Dsu.make (n + 1) in
  for i = 1 to m do
    Scanf.scanf " %d %d %d" (fun x y z -> Dsu.union dsu x y)
  done;
  List.map (List.range ~stop:`inclusive 1 n) ~f:(Dsu.find dsu)
  |> List.dedup_and_sort ~compare:Int.compare
  |> List.length
  |> printf "%d"
;;

let () = Scanf.scanf "%d %d" sol
