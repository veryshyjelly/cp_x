# Created by Ayush Biswas at 2026/07/18 18:15
# https://atcoder.jp/contests/adt_all_20260624_1/tasks/abc240_b
import lib/cpio

# @code begin

import sequtils

var r = newReader()

let
  n = r[int]
  a = r[seq[int]]

echo a.deduplicate(false).len

# @code end
