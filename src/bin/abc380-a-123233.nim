# Created by Ayush Biswas at 2026/07/19 10:33
# https://atcoder.jp/contests/adt_easy_20241226_2/tasks/abc380_a
import ../lib/cpio

# @code begin

import algorithm

var r = newReader()

let a = r[string].sorted

if a[0 .. 5] == "122333":
  echo "Yes"
else:
  echo "No"

# @code end
