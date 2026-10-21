(* Created by Ayush Biswas at 2026/06/23 11:51
https://atcoder.jp/contests/abc126/tasks/abc126_b *)
open Core

let valid_month m = m >= 1 && m <= 12

let sol s =
  let a = Int.of_string @@ String.prefix s 2
  and b = Int.of_string @@ String.suffix s 2 in
  let res =
    match valid_month a, valid_month b with
    | true, true -> "AMBIGUOUS"
    | true, false -> "MMYY"
    | false, true -> "YYMM"
    | false, false -> "NA"
  in
  printf "%s" res
;;

let () = Scanf.scanf "%s" sol
