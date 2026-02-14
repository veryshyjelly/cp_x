// Created by Ayush Biswas at 2025/12/10 11:10
// https://codeforces.com/problemset/problem/2059/C
use cp_lib::*;

use cpio::*;
use std::cmp::Reverse;
// @code begin
use std::collections::BinaryHeap;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        n: usize,
        a: [[usize]; n]
    ) -> usize {
        let mut validity = BinaryHeap::new();
        for i in  0..n {
            let mut val = 0usize;
            for j in (0..n).rev() {
                if a[i][j] == 1 {
                    val += 1;
                } else {
                    break;
                }
            }
            validity.push(Reverse(val));
        }
        let mut curr_level = 0;
        while !validity.is_empty() {
            let top = validity.pop().unwrap().0;
            if top >= curr_level {
                curr_level += 1;
            }
        }
        curr_level
    }
}

// @code end
