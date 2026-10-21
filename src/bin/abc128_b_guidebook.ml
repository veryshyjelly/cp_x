(* Created by Ayush Biswas at 2026/06/24 18:16
https://atcoder.jp/contests/abc128/tasks/abc128_b *)
open Core

let sol n =
  let restaurants =
    Array.init n ~f:(fun i ->
      Scanf.scanf " %s %d" (fun name points -> i + 1, name, points))
  in
  Array.sort
    restaurants
    ~compare:
      (Comparable.lexicographic
         [ (fun (_, s1, p1) (_, s2, p2) -> String.compare s1 s2)
         ; (fun (_, s1, p1) (_, s2, p2) -> Int.descending p1 p2)
         ]);
  let res =
    Array.map restaurants ~f:(fun (i, _, _) -> Int.to_string i)
    |> String.concat_array ~sep:"\n"
  in
  printf "%s" res
;;

let () = Scanf.scanf "%d" sol
