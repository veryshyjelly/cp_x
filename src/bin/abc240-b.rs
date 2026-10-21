// Created by Ayush Biswas at 2026/07/26 22:50
// https://atcoder.jp/contests/adt_all_20260624_1/tasks/abc240_b
// D - Count Distinct Integers

use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: usize,
        a: [usize; n]
    ) -> usize {
        a.into_iter().unique().count()
    }
}
