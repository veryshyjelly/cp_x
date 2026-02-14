// Created by Ayush Biswas at 2025/12/13 20:32
// https://atcoder.jp/contests/abc435/tasks/abc435_c
import lib/cpio.{
  type IOResult, Int, ParseInt, ParseWords, WordsInt, parse, to_string,
}

// @code begin
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/yielder
import stdin

pub fn solve(lines: List(String)) -> IOResult {
  let assert #(Int(n), lines) = parse(lines, ParseInt)
  let assert #(WordsInt(a), _lines) = parse(lines, ParseWords(ParseInt))

  let res =
    a
    |> list.try_fold(#(0, 0), fn(aci, ai) {
      let #(acc, i) = aci
      case acc < i {
        True -> Error(acc + 1)
        False -> {
          Ok(#(int.max(acc, i + ai - 1), i + 1))
        }
      }
    })
    |> result.map(fn(index) { index.0 + 1 })
    |> result.unwrap_both
    |> int.min(n)

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
