(* Created by Ayush Biswas at 2026/06/23 13:22
https://atcoder.jp/contests/abc126/tasks/abc126_d *)
open Core

let rec dfs ~graph ~visited ~colors ~node ~color =
  visited.(node) <- true;
  colors.(node) <- color;
  List.iter graph.(node) ~f:(fun (neigh, dist) ->
    if not visited.(neigh)
    then dfs ~graph ~visited ~colors ~node:neigh ~color:(color lxor dist))
;;

let sol n =
  let graph = Array.create ~len:(n + 1) [] in
  for i = 2 to n do
    Scanf.scanf " %d %d %d" (fun a b w ->
      graph.(a) <- (b, w land 1) :: graph.(a);
      graph.(b) <- (a, w land 1) :: graph.(b))
  done;
  let colors = Array.create ~len:(n + 1) 0
  and visited = Array.create ~len:(n + 1) false in
  dfs ~graph ~visited ~colors ~node:1 ~color:0;
  for i = 1 to n do
    printf "%d\n" colors.(i)
  done;
  ()
;;

let () = Scanf.scanf "%d" sol
