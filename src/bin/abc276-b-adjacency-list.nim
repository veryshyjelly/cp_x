# Created by Ayush Biswas at 2026/07/19 17:06
# https://atcoder.jp/contests/adt_easy_20240110_2/tasks/abc276_b
import ../lib/cpio

# @code begin

import algorithm

var r = newReader()

let
  (n, m) = r[int, int]
  roads = r[seq[seq[int]], m]

var graph = newSeq[seq[int]](n + 1)

for road in roads:
  graph[road[0]].add road[1]
  graph[road[1]].add road[0]

for i in 1 .. n:
  var res = @[graph[i].len]
  res.add graph[i].sorted
  echo Words(res)

# @code end

