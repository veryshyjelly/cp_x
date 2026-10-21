// Created by Ayush Biswas at 2026/07/08 21:24
// https://atcoder.jp/contests/adt_easy_20250122_3/tasks/abc369_a
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        [a, b]: [usize; 2]
    ) -> usize {
        if a == b {
            1
        } else if (a + b) % 2 == 0 {
            3
        } else {
            2
        }
    }
}
// @code end
