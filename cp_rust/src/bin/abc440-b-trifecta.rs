// Created by Ayush Biswas at 2026/07/07 21:39
// https://atcoder.jp/contests/adt_all_20260224_1/tasks/abc440_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> Words<usize> {
        let horses = a.into_iter().enumerate().map(|(i, j)| (j, i)).sorted();
        let res = horses.take(3).map(|(_, pos)| pos+1).collect_vec();
        res.into()
    }
}
// @code end
