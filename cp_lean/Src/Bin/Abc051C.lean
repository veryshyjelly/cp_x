-- Created by Ayush Biswas at 2025/12/31 11:56
-- https://atcoder.jp/contests/abc051/tasks/abc051_c
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin
def getUpOrDown (s d : ℤ) : Char×Char := by
  by_cases h : s > d
  · exact ('D', 'U')
  · exact ('U', 'D')

def getRightOrLeft (s d : ℤ) : Char×Char := by
  by_cases h : s > d
  · exact ('L', 'R')
  · exact ('R', 'L')

def solution : List (List ℤ) -> String
| [[sx, sy, tx, ty]] =>
    let (u, d) := getUpOrDown sx tx
    let (r, l) := getRightOrLeft sy ty
    let (dx, dy) := ((sx - tx).natAbs, (sy - ty).natAbs)
    let rep := String.replicate
    let path₁ := (rep dy u) ++ (rep dx r) ++ (rep dy d) ++ (rep dx l)
    let going₂ := l.toString ++ (rep dy u) ++ (String.mk [u, r]) ++ (rep dx r) ++ d.toString
    let coming₂ := r.toString ++ (rep dy d) ++ (String.mk [d, l]) ++ (rep dx l) ++ u.toString
    path₁ ++ going₂ ++ coming₂
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
