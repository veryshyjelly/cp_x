// Created by Ayush Biswas at 2025/12/13 20:32
// https://atcoder.jp/contests/abc435/tasks/abc435_c
import lib/cpio.{
  type IOResult, Int, ParseInt, ParseWords, WordsInt, parse, to_string,
}

// @head begin
import gleam/int
import gleam/io
import gleam/yielder
import stdin

// @head end

// @code begin
// Using try_folds causes to pattern match on each itertion
// using if else is much lighter than that
fn go(xs: List(Int), acc: Int, i: Int, n: Int) -> Int {
  case xs {
    [] -> int.min(acc + 1, n)

    [ai, ..rest] ->
      case acc < i {
        True -> int.min(acc + 1, n)
        False -> go(rest, int.max(acc, i + ai - 1), i + 1, n)
      }
  }
}

pub fn solve(lines: List(String)) -> IOResult {
  let assert #(Int(n), lines) = parse(lines, ParseInt)
  let assert #(WordsInt(a), _lines) = parse(lines, ParseWords(ParseInt))

  let res = go(a, 0, 0, n)

  Int(res)
}

pub fn main() {
  stdin.read_lines()
  |> yielder.to_list
  |> solve
  |> to_string
  |> io.println
}
// @code end
