(* Created by Ayush Biswas at 2026/06/23 15:23
https://atcoder.jp/contests/abc126/tasks/abc126_f *)
open Core

let create_list m k =
  let n = Int.pow 2 m in
  let l = List.range 0 n |> List.filter ~f:(( <> ) k) in
  let a, b =
    match k with
    | 0 -> [ 0; 0 ], []
    | _ -> [ k ], [ k ]
  in
  List.concat [ l; a; List.rev l; b ]
;;

let sol m k =
  printf "%s"
  @@
  if k >= Int.pow 2 m || (k <> 0 && m <= 1)
  then "-1"
  else (
    let res = create_list m k in
    res |> List.map ~f:Int.to_string |> String.concat ~sep:" ")
;;

let () = Scanf.scanf "%d %d" sol
