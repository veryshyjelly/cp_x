# Created by Ayush Biswas at 2026/07/18 19:21
# https://atcoder.jp/contests/adt_easy_20260204_2/tasks/abc392_a
import lib/cpio

# @code begin

import algorithm

var r = newReader()

let a = r[seq[int]].sorted

if a[0] * a[1] == a[2]:
  echo "Yes"
else:
  echo "No"

# @code end
