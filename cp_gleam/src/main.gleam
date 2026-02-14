import lib/cpio.{type IOResult, Int, ParseInt, parse, to_string}

// @code begin
import gleam/io
import gleam/yielder
import stdin

pub fn solve(lines: List(String)) -> IOResult {
  let assert #(Int(n), _lines) = parse(lines, ParseInt)
  let m = n * { n + 1 }
  Int(m / 2)
}

pub fn main() {
  stdin.read_lines()
  |> yielder.to_list
  |> solve
  |> to_string
  |> io.println
}
// @code end
