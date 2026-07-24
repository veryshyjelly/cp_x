# Created by Ayush Biswas at 2026/07/19 08:35
# https://atcoder.jp/contests/adt_medium_20250723_3/tasks/abc409_b
import ../lib/cpio

# @code begin

import algorithm, math

var r = newReader()

let
  n = r[int]
  a = r[seq[int]].sorted

var res: int
for i, x in a.pairs:
  let el = (n - i)
  res = res.max (x.min el)

echo res
# @code end
