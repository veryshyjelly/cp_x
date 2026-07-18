// Created by Ayush Biswas at 2026/07/08 20:25
// https://atcoder.jp/contests/adt_medium_20250415_3/tasks/abc394_b
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        n: usize,
        (mut s): [String]; n
    ) -> String {
        s.sort_by_key(|x| x.len());
        s.join("")
    }
}
// @code end
