// Created by Ayush Biswas at 2026/07/07 23:05
// https://atcoder.jp/contests/adt_easy_20260204_2/tasks/abc392_a
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        (mut a): [usize]
    ) -> Bool {
        a.sort();
        (a[0] * a[1] == a[2]).into()
    }
}
// @code end
