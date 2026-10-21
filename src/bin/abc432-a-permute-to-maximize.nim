# Created by Ayush Biswas at 2026/07/18 19:32
# https://atcoder.jp/contests/adt_easy_20260107_3/tasks/abc432_a
import ../lib/cpio

# @code begin

import algorithm, sequtils

var r = newReader()

let a = r[seq[int]].sorted.reversed

echo a.mapIt($it).join("")

# @code end
