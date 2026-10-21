-- Created by Ayush Biswas at 2025/12/18 21:41
-- https://atcoder.jp/contests/abc042/tasks/abc042_b
import Src.Cpio

-- @code begin

def solution : List String → String
| nl :: ss => ss.mergeSort |> String.join
| [] => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
