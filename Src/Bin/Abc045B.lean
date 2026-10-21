-- Created by Ayush Biswas at 2025/12/20 22:30
-- https://atcoder.jp/contests/abc045/tasks/abc045_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
inductive Turn where
| Alice
| Bob
| Charlie

def Turn.ofChar : Char -> Turn
| 'a' => Alice
| 'b' => Bob
| 'c' => Charlie
| _ => Alice

open Turn in
def game (alice bob charlie : List Char) : Turn -> Char
| Alice => match alice with
  | a :: as => game as bob charlie (Turn.ofChar a)
  | [] => 'A'
| Bob => match bob with
  | b :: bs => game alice bs charlie (Turn.ofChar b)
  | [] => 'B'
| Charlie => match charlie with
  | c :: cs => game alice bob cs (Turn.ofChar c)
  | [] => 'C'

def solution : List String -> String
| [a, b, c] => game a.toList b.toList c.toList Turn.Alice |> toString
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
