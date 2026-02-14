// Created by Ayush Biswas at 2025/12/03 21:59
// https://codeforces.com/problemset/problem/1862/E
use cp_lib::*;

// @code begin
use cpio::*;
use std::cmp::Reverse;
use std::collections::BinaryHeap;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [n, m, d]: [usize; 3],
        a: [isize]
    ) -> isize {
        let d = d as isize;
        let mut heap: BinaryHeap<Reverse<isize>> = BinaryHeap::new();
        let mut heap_sum = 0;
        let mut max_sum = 0;
        for i in 0..n {
            let now_sum = heap_sum + (a[i] - (i as isize + 1) * d);
            max_sum = max_sum.max(now_sum);
            if a[i] > 0 {
                heap.push(Reverse(a[i]));
                heap_sum += a[i];
            }
            if heap.len() >= m {
                heap_sum -= heap.pop().unwrap().0;
            }
        }
        max_sum
    }
}

// @code end
