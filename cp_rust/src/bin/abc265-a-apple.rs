// Created by Ayush Biswas at 2026/07/07 20:30
// https://atcoder.jp/contests/adt_easy_20260617_1/tasks/abc265_a
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        [x, y, n]: [usize; 3]
    ) -> usize {
        if 3*x <= y {
            n * x
        } else {
            (n/3)*y + (n%3)*x
        }
    }
}
// @code end
