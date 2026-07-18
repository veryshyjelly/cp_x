# Created by Ayush Biswas at 2026/07/18 18:43
# https://atcoder.jp/contests/adt_easy_20260617_1/tasks/abc434_b
import ../lib/cpio

# @code begin

import sequtils

var r = newReader()

let
  (n, m) = r[int, int]
  birds = r[seq[seq[int]], n]

var weights = newSeq[int](m)
var counts = newSeq[int](n)

for bird in birds:
  weights[bird[0] - 1] += bird[1]
  counts[bird[0] - 1] += 1

for i in 0 ..< m:
  echo weights[i] / counts[i]

# @code end
