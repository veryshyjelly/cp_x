# Created by Ayush Biswas at 2026/07/19 09:52
# https://atcoder.jp/contests/adt_easy_20250122_3/tasks/abc369_a
import ../lib/cpio

# @code begin

var r = newReader()

let (a, b) = r[int, int]

if a == b:
  echo 1
elif (a + b) mod 2 == 0:
  echo 3
else:
  echo 2

# @code end
