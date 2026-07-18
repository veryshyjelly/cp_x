import strutils

# ==============================================================================
# 1. FAST I/O SCANNER
# ==============================================================================
type
  Reader* = ref object
    lines: seq[seq[string]]
    lineIdx: int
    tokenIdx: int

proc newReader*(): Reader =
  result = Reader()
  result.lines = @[]
  # Read all stdin at once for max speed, split by lines, skip empty lines
  for line in stdin.readAll().splitLines():
    let tokens = line.splitWhitespace()
    if tokens.len > 0:
      result.lines.add(tokens)
  result.lineIdx = 0
  result.tokenIdx = 0

proc nextStr*(r: var Reader): string =
  if r.lineIdx >= r.lines.len: return ""
  if r.tokenIdx >= r.lines[r.lineIdx].len:
    inc r.lineIdx
    r.tokenIdx = 0
    return r.nextStr()
  result = r.lines[r.lineIdx][r.tokenIdx]
  inc r.tokenIdx

proc nextInt*(r: var Reader): int = parseInt(r.nextStr())
proc nextFloat*(r: var Reader): float = parseFloat(r.nextStr())

template carriageReturn(r: var Reader) =
  if r.lineIdx < r.lines.len and r.tokenIdx >= r.lines[r.lineIdx].len:
    r.tokenIdx = 0
    inc r.lineIdx

# "Rest of the line" readers
proc readLineInts*(r: var Reader): seq[int] =
  carriageReturn(r)
  if r.lineIdx >= r.lines.len: return @[]
  let tokens = r.lines[r.lineIdx]
  result = newSeq[int](tokens.len - r.tokenIdx)
  for i in r.tokenIdx ..< tokens.len:
    result[i - r.tokenIdx] = parseInt(tokens[i])
  inc r.lineIdx
  r.tokenIdx = 0

proc readLineStrs*(r: var Reader): seq[string] =
  carriageReturn(r)
  if r.lineIdx >= r.lines.len: return @[]
  let tokens = r.lines[r.lineIdx]
  result = tokens[r.tokenIdx ..^ 1]
  inc r.lineIdx
  r.tokenIdx = 0

proc readLineFloats*(r: var Reader): seq[float] =
  carriageReturn(r)
  if r.lineIdx >= r.lines.len: return @[]
  if r.lineIdx >= r.lines.len: return @[]
  let tokens = r.lines[r.lineIdx]
  result = newSeq[float](tokens.len - r.tokenIdx)
  for i in r.tokenIdx ..< tokens.len:
    result[i - r.tokenIdx] = parseFloat(tokens[i])
  inc r.lineIdx
  r.tokenIdx = 0

# ==============================================================================
# 2. SPECIALIZED TYPES (Binary, Chars)
# ==============================================================================
type
  Binary* = distinct seq[int]
  Chars* = distinct seq[char]

proc `$`*(b: Binary): string =
  var s = ""
  for x in seq[int](b): s.add(if x == 1: '1' else: '0')
  s

proc `$`*(c: Chars): string =
  var s = ""
  for x in seq[char](c): s.add(x)
  s

proc readBinary*(r: var Reader): Binary =
  let s = r.nextStr()
  var res = newSeq[int](s.len)
  for i, c in s:
    if c == '1': res[i] = 1
    elif c == '0': res[i] = 0
    else: raise newException(ValueError, "Invalid binary char: " & c)
  return Binary(res)

proc readChars*(r: var Reader): Chars =
  let s = r.nextStr()
  var res = newSeq[char](s.len)
  for i, c in s: res[i] = c
  return Chars(res)

# ==============================================================================
# 3. GENERIC READ DISPATCHER (Compile-Time Branching)
# ==============================================================================
proc read*(r: var Reader, T: typedesc): T =
  when T is int: r.nextInt()
  elif T is float: r.nextFloat()
  elif T is string: r.nextStr()
  elif T is seq[int]: r.readLineInts()
  elif T is seq[string]: r.readLineStrs()
  elif T is seq[float]: r.readLineFloats()
  elif T is Binary: r.readBinary()
  elif T is Chars: r.readChars()
  else: T.default
    {.error: "Unsupported type for read: " & $T.}

# ==============================================================================
# 4. THE `[]` OPERATOR OVERLOADS
# ==============================================================================
# Single value
proc `[]`*[T1](r: var Reader, _: typedesc[T1]): T1 = r.read(T1)

# Tuple unpacking (Arbitrary up to 5 elements, no macros needed!)
proc `[]`*[T1, T2](r: var Reader, _: typedesc[T1], _: typedesc[T2]): (T1, T2) =
  (r.read(T1), r.read(T2))
proc `[]`*[T1, T2, T3](r: var Reader, _: typedesc[T1], _: typedesc[T2], _: typedesc[T3]): (T1, T2, T3) =
  (r.read(T1), r.read(T2), r.read(T3))
proc `[]`*[T1, T2, T3, T4](r: var Reader, _: typedesc[T1], _: typedesc[T2], _: typedesc[T3], _: typedesc[T4]): (T1, T2, T3, T4) =
  (r.read(T1), r.read(T2), r.read(T3), r.read(T4))
proc `[]`*[T1, T2, T3, T4, T5](r: var Reader, _: typedesc[T1], _: typedesc[T2], _: typedesc[T3], _: typedesc[T4], _: typedesc[T5]): (T1, T2, T3, T4, T5) =
  (r.read(T1), r.read(T2), r.read(T3), r.read(T4), r.read(T5))

# Multi-line / Repetition reading (e.g., r[seq[seq[int]], q])
proc `[]`*[T](r: var Reader, _: typedesc[seq[T]], count: int): seq[T] =
  result = newSeq[T](count)
  for i in 0 ..< count:
    result[i] = r.read(T)

# ==============================================================================
# 5. OUTPUT FORMATTING
# ==============================================================================
type
  YesNo* = distinct bool

proc `$`*(b: YesNo): string =
  if bool(b): "Yes" else: "No"

type
  Words*[T] = distinct seq[T]
  Lines*[T] = distinct seq[T]

proc `$`*[T](w: Words[T]): string =
  var parts: seq[string]
  for x in seq[T](w): parts.add($x)
  parts.join(" ")

proc `$`*[T](l: Lines[T]): string =
  var parts: seq[string]
  for x in seq[T](l): parts.add($x)
  parts.join("\n")
