# Created by Ayush Biswas at 2026/07/19 08:33
# https://atcoder.jp/contests/adt_medium_20250812_3/tasks/abc408_b
import ../lib/cpio

# @code begin

import sequtils, algorithm

var r = newReader()

let
  n = r[int]
  a = r[seq[int]].deduplicate(false).sorted

echo a.len
echo Words(a)

# @code end
