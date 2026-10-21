(* Created by Ayush Biswas at 2026/07/05 09:36 
   https://atcoder.jp/contests/abc130/tasks/abc130_c *)
open Core

let sol w h x y =
  let area = float (h * w) in
  let ways = if h % 2 = 0 && w % 2 = 0 && x = w / 2 && y = h / 2 then 1 else 0 in
  printf "%f %d" (area /. 2.0) ways
;;

let () = Scanf.scanf "%d %d %d %d" sol
