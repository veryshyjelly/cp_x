# Created by Ayush Biswas at 2026/07/18 19:00
# https://atcoder.jp/contests/adt_easy_20260407_2/tasks/abc448_b
import ../lib/cpio

# @code begin

import math

var r = newReader()

var
  (n, m) = r[int, int]
  limits = r[seq[int]]
  peppers = r[seq[seq[int]], n]

var res: int
for pepper in peppers:
  res += limits[pepper[0] - 1].min pepper[1]
  limits[pepper[0] - 1] = max(limits[pepper[0] - 1] - pepper[1], 0)

echo res

# @code end
