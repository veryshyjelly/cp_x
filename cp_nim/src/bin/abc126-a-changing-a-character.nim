# Created by Ayush Biswas at 2026/07/18 12:42
# https://atcoder.jp/contests/abc126/tasks/abc126_a
import ../lib/cpio

# @code begin

import strutils

var r = newReader()

var
  (n, k) = r[int, int]
  s = r[string]

s[k - 1] = s[k - 1].toLowerAscii
echo s

# @code end
