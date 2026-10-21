# Created by Ayush Biswas at 2026/07/18 20:46
# https://atcoder.jp/contests/adt_easy_20251224_1/tasks/abc432_b
import ../lib/cpio

# @code begin

import algorithm, strutils, sugar

var r = newReader()

var s = r[string].sorted

for i in 0 .. s.high:
  if s[i] != '0':
    let j = s[i]
    s[i] = '0'
    s[0] = j
    break

echo s.join("")

# @code end
