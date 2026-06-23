// Created by Ayush Biswas at 2026/05/08 19:37
// https://open.kattis.com/problems/continuousmedian
use cp_lib::*;

// @code begin
use cpio::*;
use std::cmp::Reverse;
use std::collections::BinaryHeap;
// const INF: u32 = 10u32.pow(9);
const INF: usize = 4 * 10usize.pow(18);

#[derive(Default)]
struct Median {
    first: BinaryHeap<usize>,
    second: BinaryHeap<Reverse<usize>>,
}

impl Median {
    fn insert(&mut self, num: usize) {
        let &limit = self.first.peek().unwrap_or(&INF);
        if num > limit {
            self.second.push(Reverse(num));
            if self.second.len() > self.first.len() {
                let Reverse(popped) = self.second.pop().unwrap();
                self.first.push(popped);
            }
        } else {
            self.first.push(num);
            if self.first.len() > self.second.len() + 1 {
                let popped = self.first.pop().unwrap();
                self.second.push(Reverse(popped));
            }
        }
    }

    fn query(&self) -> usize {
        if self.first.len() == self.second.len() {
            let a = self.first.peek().unwrap();
            let Reverse(b) = self.second.peek().unwrap();
            (a + b) / 2
        } else {
            *self.first.peek().unwrap()
        }
    }
}

sol_n! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> usize {
        let mut median = Median::default();
        let mut res = 0;
        for ai in a {
            median.insert(ai);
            res += median.query();
        }
        res
    }
}

// @code end
