# Created by Ayush Biswas at 2026/07/19 09:44
# https://atcoder.jp/contests/adt_medium_20250521_3/tasks/abc392_b
import ../lib/cpio

# @code begin

import sequtils

var r = newReader()

let
  (n, m) = r[int, int]
  a = r[seq[int]]

let res = (1 .. n).toSeq.filterIt(it notin a)

echo res.len
echo Words(res)

# @code end
