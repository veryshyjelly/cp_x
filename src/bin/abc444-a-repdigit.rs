// Created by Ayush Biswas at 2026/07/07 20:59
// https://atcoder.jp/contests/adt_easy_20260508_1/tasks/abc444_a
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: [char]
    ) -> Bool {
        (n.into_iter().group_by(|&x| x).count() == 1).into()
    }
}
// @code end
