// Created by Ayush Biswas at 2026/07/27 17:03
// https://atcoder.jp/contests/adt_easy_20260617_1/tasks/abc265_a
// A - Apple

use cpio::*;

sol! {
    fn solution(
        x: usize, y: usize, n: usize
    ) -> usize {
        usize::min(3 * x, y) * (n / 3) + x * (n % 3)
    }
}
