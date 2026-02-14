// Created by Ayush Biswas at 2026/01/24 22:15
// https://atcoder.jp/contests/abc043/tasks/arc059_a
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        _n: usize,
        a: [isize]
    ) -> usize {
        (-100..=100).map(|y| cost(&a, y)).min().unwrap()
    }
}

fn cost(a: &Vec<isize>, y: isize) -> usize {
    a.iter().map(|ai| (ai - y).pow(2)).sum::<isize>() as usize
}
// @code end
