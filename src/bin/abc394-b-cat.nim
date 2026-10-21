# Created by Ayush Biswas at 2026/07/19 09:48
# https://atcoder.jp/contests/adt_medium_20250415_3/tasks/abc394_b
import ../lib/cpio

# @code begin

import algorithm

var r = newReader()

let n = r[int]
let res = r[seq[string], n].sortedByIt(it.len).join("")

echo res

# @code end
