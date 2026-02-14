import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def fillOs (s : String) : ℕ -> String
  | 0     => s
  | n + 1   => fillOs ("o" ++ s) n

def solution : ℤ × List (List String) -> String
| (n, s) => match s with
  | [[s]] => fillOs s (n - s.length).toNat
  | _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
