// Created by Ayush Biswas at 2026/07/08 13:05
// https://atcoder.jp/contests/adt_easy_20250903_1/tasks/abc402_b
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::VecDeque;

sol! {
    fn solution(
        n: usize,
        queries: [[usize]; n]
    ) -> Lines<usize> {
        let mut queue = VecDeque::new();
        let mut res = vec![];
        for q in queries {
            if q[0] == 1 {
                queue.push_back(q[1]);
            } else if q[0] == 2 {
                res.push(queue.pop_front().unwrap());
            }
        }
        res.into()
    }
}
// @code end
