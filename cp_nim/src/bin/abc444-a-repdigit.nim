# Created by Ayush Biswas at 2026/07/18 18:53
# https://atcoder.jp/contests/adt_easy_20260508_1/tasks/abc444_a
import lib/cpio

# @code begin

import sequtils

var r = newReader()

let s = r[string]

if s.deduplicate(false).len == 1:
  echo "Yes"
else:
  echo "No"

# @code end
