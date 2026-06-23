// Created by Ayush Biswas at 2026/05/11 13:45
// https://open.kattis.com/problems/arraysmoothening
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::collections::BinaryHeap;

sol! {
    fn solution(
        [_, k]: [usize; 2],
        a: [usize]
    ) -> usize {
        let mut freq: BinaryHeap<usize> = a
            .into_iter()
            .sorted()
            .group_by(|&x| x)
            .map(|g| g.len())
            .collect();
        let mut p = freq.pop().unwrap();
        if freq.is_empty() {
            return p - k;
        }
        for _ in 0..k {
            p -= 1;
            if p < *freq.peek().unwrap() {
                freq.push(p);
                p = freq.pop().unwrap();
            }
        }
        p
    }
}
// @code end
