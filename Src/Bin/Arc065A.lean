-- Created by Ayush Biswas at 2025/12/28 12:40
-- https://atcoder.jp/contests/abc049/tasks/arc065_a
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def wordBank := ["dream", "dreamer", "erase", "eraser"]

def matchWord (i : ℕ) (s w : String) (reachable : Array Bool) : Array Bool :=
  if h : reachable.size <= (i + w.length) then reachable
  else if reachable[i] ∧ not reachable[i + w.length] ∧ (s.extract ⟨i⟩ ⟨i + w.length⟩ = w)
  then reachable.set (i + w.length) true
  else reachable

def solution : List String -> String
| [s] =>
  let n := s.length + 1
  let reachable := List.range n |>.foldl (λ acc i =>
     wordBank.foldl (λ acc word => matchWord i s word acc) acc
  ) (Array.replicate n false |>.set! 0 true)
  if reachable[n - 1]! then "YES" else "NO"
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
