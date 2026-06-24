(* Created by Ayush Biswas at 2026/06/23 11:09 *)
(* https://atcoder.jp/contests/abc126/tasks/abc126_a *)
open Core

let sol n k s =
  let b = Bytes.of_string s in
  Bytes.set b (k - 1) (Char.lowercase @@ Bytes.get b (k - 1));
  let s = Bytes.to_string b in
  printf "%s" s
;;

let () = Scanf.scanf "%d %d\n%s" sol
