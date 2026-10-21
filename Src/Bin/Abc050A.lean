-- Created by Ayush Biswas at 2025/12/30 11:55
-- https://atcoder.jp/contests/abc050/tasks/abc050_a
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List (List String) -> ℤ
| [formula] =>
  have : formula.length = 3 := given
  let [a, op, b] := formula
  match op with
  | "+" => a.toInt! + b.toInt!
  | "-" => a.toInt! - b.toInt!
  | _ => 0
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
