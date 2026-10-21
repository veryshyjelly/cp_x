# Created by Ayush Biswas at 2026/07/18 18:47
# https://atcoder.jp/contests/adt_all_20260615_2/tasks/abc456_b
import ../lib/cpio

# @code begin

import algorithm

var r = newReader()

let
  a = r[seq[int]]
  b = r[seq[int]]
  c = r[seq[int]]

var numWays: int

for i in 0 ..< 6:
  for j in 0 ..< 6:
    for k in 0 ..< 6:
      let rolls = @[a[i], b[j], c[k]].sorted
      if rolls == @[4, 5, 6]:
        inc numWays

echo numWays / (6 * 6 * 6)

# @code end
