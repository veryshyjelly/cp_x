# Created by Ayush Biswas at 2026/07/19 12:11
# https://atcoder.jp/contests/adt_easy_20240215_1/tasks/abc274_a
import ../lib/cpio

# @code begin

import strformat

var r = newReader()

let (a, b) = r[int, int]

let res = b / a

echo &"{res:.3f}"

# @code end

