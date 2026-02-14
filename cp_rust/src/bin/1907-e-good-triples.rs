// Created by Ayush Biswas at 2025/12/10 18:08
// https://codeforces.com/problemset/problem/1907/E
use cp_lib::*;

// @code begin
use cpio::*;
use std::sync::OnceLock;
use itertools::Itertools;

const NC2: OnceLock<Vec<usize>> = OnceLock::new();

fn compute() -> Vec<usize> {
    (0..10).map(|x| ((x+2)*(x+1)) / 2).collect_vec()
}

sol_n! {
    fn solution(
        n: String,
    ) -> usize {
        let nc2 = NC2.get_or_init(compute).clone();
        let mut res = 1;
        for c in n.bytes() {
            res *= nc2[(c - b'0') as usize];
        }
        res
    }
}

// @code end
