# Created by Ayush Biswas at 2026/07/18 19:09
# https://atcoder.jp/contests/adt_all_20260224_1/tasks/abc440_b
import ../lib/cpio

# @code begin

import algorithm, sequtils

var r = newReader()

let
  n = r[int]
  horses = r[seq[int]]

let mules: seq[int] = horses.pairs().toSeq.sortedByIt(it.val).mapIt(it.key + 1)

echo Words(mules[0..2])

# @code end
