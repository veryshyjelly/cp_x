// Created by Ayush Biswas at 2026/07/08 10:05
// https://atcoder.jp/contests/adt_easy_20251023_3/tasks/abc419_b
use cp_lib::*;

// @code begin
use cpio::*;
use std::cmp::Reverse;
use std::collections::BinaryHeap;

sol! {
    fn solution(
        n: usize,
        queries: [[usize]; n]
    ) -> Lines<usize> {
        let mut res = vec![];
        let mut heap = BinaryHeap::new();
        for q in queries {
            if q[0] == 1 {
                heap.push(Reverse(q[1]));
            } else {
                let Reverse(r) = heap.pop().unwrap();
                res.push(r);
            }
        }
        res.into()
    }
}
// @code end
