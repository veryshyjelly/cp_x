# Created by Ayush Biswas at 2026/07/19 23:50
# https://atcoder.jp/contests/adt_all_20231226_2/tasks/abc291_b
import ../lib/cpio

# @code begin

import algorithm, math

var r = newReader()

let
  n = r[int]
  a = r[seq[int]].sorted

echo a[n ..< 4*n].sum / (3 * n)
# @code end

