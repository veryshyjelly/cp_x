import std/tables

proc groupBy*[T, K](s: openArray[T], key: proc(x: T): K): Table[K, seq[T]] =
  for x in s:
    result.mgetOrPut(key(x), @[]).add(x)
