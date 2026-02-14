// Created by Ayush Biswas at 2025/12/13 19:08
// https://atcoder.jp/contests/abc435/tasks/abc435_b
import lib/cpio.{
  type IOResult, Int, ParseInt, ParseWords, WordsInt, parse, to_string,
}

// @code begin
import gleam/int
import gleam/io
import gleam/list
import gleam/yielder
import stdin

pub fn solve(lines: List(String)) -> IOResult {
  let assert #(Int(n), lines) = parse(lines, ParseInt)
  let assert #(WordsInt(a), _lines) = parse(lines, ParseWords(ParseInt))
  Int(process_tails(a))
}

// Outer Recursion: Iterates through every starting position
fn process_tails(list: List(Int)) -> Int {
  case list {
    [] -> 0
    [head, ..tail] -> {
      // 1. Process all subarrays starting with 'head'
      // 2. Recurse to process subarrays starting with the next element
      process_subarrays([head], tail) + process_tails(tail)
    }
  }
}

// Inner Recursion: Grows the subarray by prepending
fn process_subarrays(current: List(Int), remaining: List(Int)) -> Int {
  let score = condition(current)

  case remaining {
    [] -> score
    [next, ..rest] -> {
      score + process_subarrays([next, ..current], rest)
    }
  }
}

pub fn condition(arr: List(Int)) -> Int {
  let sum = arr |> list.fold(0, int.add)
  let res = arr |> list.all(fn(a) { sum % a != 0 })
  case res {
    True -> 1
    False -> 0
  }
}

pub fn main() {
  stdin.read_lines()
  |> yielder.to_list
  |> solve
  |> to_string
  |> io.println
}
// @code end
