-- Created by Ayush Biswas at 2025/12/16 12:50
-- https://atcoder.jp/contests/abc436/tasks/abc436_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
open CPio

def zeroMatrix (n : ℕ) : Array (Array ℤ) :=
  Array.replicate n (Array.replicate n 0)

def setAt (m : Array (Array ℤ)) (i j : ℕ) (v : ℕ) :=
  if h₁ : i < m.size then
    let row := m[i]
    if h₂ : j < row.size then
      m.set i (row.set j v)
    else m
  else m

def fillMatrix
  (n : ℕ)
  (lastFill : ℕ)
  (lastLoc : ℕ × ℕ)
  (arr : Array (Array ℤ)) : Array (Array ℤ) :=

  let (r, c) := lastLoc
  let (r₁, c₁) := ((r + n - 1) % n, (c + 1) % n)
  let (r₂, c₂) := ((r + 1) % n, c)
  let nextFill := lastFill + 1
  let row := arr[r₁]!
  if lastFill < n^2 then
    if row[c₁]! = 0 then
    fillMatrix n nextFill (r₁, c₁) (setAt arr r₁ c₁ nextFill)
    else fillMatrix n nextFill (r₂, c₂) (setAt arr r₂ c₂ nextFill)
  else arr

termination_by
  (n ^ 2 - lastFill)

def solution : List (List ℤ) → ListOf (ListOf ℤ)
| [[n]] =>
  let n := n.toNat
  let firstC := (n - 1) / 2
  let mat := setAt (zeroMatrix n) 0 firstC 1
  let filledMat := fillMatrix n 1 (0, firstC) mat
  ListOf.LinesOf (filledMat.toList.map (ListOf.WordsOf ·.toList))
| _ => ListOf.LinesOf []


def main : IO Unit :=
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
