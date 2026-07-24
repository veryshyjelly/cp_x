# Created by Ayush Biswas at 2026/07/19 10:41
# https://atcoder.jp/contests/adt_easy_20240903_1/tasks/abc363_b
import ../lib/cpio

# @code begin

import algorithm

var r = newReader()

let
  (n, t, p) = r[int, int, int]
  a = r[seq[int]].sorted(Descending)

echo (t - a[p - 1]).max 0

# @code end
