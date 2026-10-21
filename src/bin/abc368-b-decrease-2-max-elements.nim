# Created by Ayush Biswas at 2026/07/19 10:35
# https://atcoder.jp/contests/adt_easy_20241001_2/tasks/abc368_b
import ../lib/cpio

# @code begin

import algorithm

var r = newReader()

var
  n = r[int]
  a = r[seq[int]].sorted(Descending)

var res: int
while a[1] > 0:
  a[0] -= 1
  a[1] -= 1
  inc res
  a.sort(Descending)

echo res
# @code end
