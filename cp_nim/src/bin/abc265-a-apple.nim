# Created by Ayush Biswas at 2026/07/18 18:39
# https://atcoder.jp/contests/adt_easy_20260617_1/tasks/abc265_a
import ../lib/cpio

# @code begin

var r = newReader()

let (x, y, n) = r[int, int, int]

if 3 * x <= y:
  echo n * x
else:
  let total = (n div 3) * y + (n mod 3) * x
  echo total

# @code end
