// Created by Ayush Biswas at 2026/07/07 11:47
// https://atcoder.jp/contests/adt_all_20260624_1/tasks/abc240_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> usize {
        a.into_iter().unique().count()
    }
}
// @code end
