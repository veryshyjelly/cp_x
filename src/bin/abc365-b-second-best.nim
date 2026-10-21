# Created by Ayush Biswas at 2026/07/19 09:54
# https://atcoder.jp/contests/adt_easy_20241231_1/tasks/abc365_b
import ../lib/cpio

# @code begin

import algorithm, sequtils

var r = newReader()

let
  n = r[int]
  a = r[seq[int]]

echo a.pairs.toSeq.sortedByIt(it.val)[^2].key + 1

# @code end
