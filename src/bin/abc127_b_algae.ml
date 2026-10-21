(* Created by Ayush Biswas at 2026/06/23 16:09
https://atcoder.jp/contests/abc127/tasks/abc127_b *)
open Core

let sol r d x100 =
  let x = ref x100 in
  for i = 1 to 10 do
    x := (!x * r) - d;
    printf "%d\n" !x
  done
;;

let () = Scanf.scanf "%d %d %d" sol
