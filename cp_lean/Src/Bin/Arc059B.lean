-- Created by Ayush Biswas at 2025/12/20 12:54
-- https://atcoder.jp/contests/abc043/tasks/arc059_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def scanTwos : List Char -> Option (ℕ×ℕ)
| x :: y :: xs => if x = y then some (1+xs.length, xs.length)
  else scanTwos (y :: xs)
| _ => none

def scanThrees : List Char -> Option (ℕ×ℕ)
| x :: y :: z :: xs => if x = z then some (2+xs.length, xs.length)
  else scanThrees (y :: z :: xs)
| _ => none

def solution : List String -> CPio.ListOf ℤ
| [s] =>
  let n := s.length
  let res := scanTwos s.toList <|> scanThrees s.toList
  match res with
  | some (a, b) => CPio.ListOf.WordsOf [n - a, n - b]
  | none => CPio.ListOf.WordsOf [-1, -1]
| _ => CPio.ListOf.WordsOf []

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
