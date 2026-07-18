// Created by Ayush Biswas at 2026/07/08 14:10
// https://atcoder.jp/contests/adt_hard_20250619_2/tasks/abc398_c
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::collections::HashMap;

sol! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> CPResult<usize, isize> {
        let mut labels = HashMap::new();
        for (i, ai) in a.clone().into_iter().enumerate() {
            labels.entry(ai).or_insert(vec![]).push(i + 1);
        }
        let mut res = 0;
        for ai in a.into_iter().sorted().unique() {
            if labels[&ai].len() == 1 {
                res = labels[&ai][0];
            }
        }

        if res == 0 {
            Failure(-1)
        } else {
            Success(res)
        }
    }
}
// @code end
