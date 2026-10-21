// Created by Ayush Biswas at 2026/05/06 18:34
// https://open.kattis.com/problems/brillianceofwings
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::collections::HashSet;

fn hash(mut l: [usize; 2], m: usize) -> usize {
    l.sort();
    let [x, y] = l;
    x * m + y
}

sol! {
    fn solution(
        n: usize,
        a: [[usize; 2]; n - 1],
        b: [[usize; 2]; n - 1]
    ) -> usize {
        let m = n + 1;
        let a: HashSet<usize> = a
            .into_iter()
            .map(|ai| hash(ai, m))
            .collect();

        let b: HashSet<usize> = b
            .into_iter()
            .map(|ai| hash(ai, m))
            .collect();

        a.symmetric_difference(&b).collect_vec().len() / 2
    }
}
// @code end
