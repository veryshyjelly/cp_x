// Created by Ayush Biswas at 2026/07/08 19:52
// https://atcoder.jp/contests/adt_medium_20250521_3/tasks/abc392_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::collections::HashSet;

sol! {
    fn solution(
        [n, m]: [usize; 2],
        a: [usize]
    ) -> Lines<Words<usize>> {
        let a: HashSet<usize> = HashSet::from_iter(a.into_iter());
        let res = (1..=n).filter(|i| !a.contains(i)).collect_vec();
        vec![
            vec![res.len()].into(),
            res.into()
        ].into()
    }
}
// @code end
