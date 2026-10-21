-- Created by Ayush Biswas at 2025/12/20 12:17
-- https://atcoder.jp/contests/abc043/tasks/abc043_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
def typeInEditor (text : List Char) : List Char -> List Char
| 'B' :: t => match text with
  | [] => typeInEditor [] t
  | _ :: tl => typeInEditor tl t
| h :: t => typeInEditor (h :: text) t
| [] => text

def solution : List String -> String
| [s] => typeInEditor [] s.toList |>.reverse |> String.mk
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
