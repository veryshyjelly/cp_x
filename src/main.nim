import lib/cpio

# @code begin

var r = newReader()

let
  n = r[int]
  a = r[seq[int]]

echo n
echo a

# @code end
