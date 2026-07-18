// Created by Ayush Biswas at 2026/07/08 13:39
// https://atcoder.jp/contests/adt_medium_20250812_3/tasks/abc408_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> Lines<Words<usize>> {
        let res = a.into_iter().sorted().unique().collect_vec();
        vec![
            vec![res.len()].into(),
            res.into()
        ].into()
    }
}
// @code end
