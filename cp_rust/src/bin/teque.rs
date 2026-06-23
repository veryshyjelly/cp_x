// Created by Ayush Biswas at 2026/05/09 21:36
// https://open.kattis.com/problems/teque
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::VecDeque;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

#[derive(Default)]
struct Teque<T> {
    left: VecDeque<T>,
    right: VecDeque<T>,
}

impl<T> Teque<T> {
    fn push_back(&mut self, item: T) {
        self.right.push_back(item);
        self.rebalance();
    }

    fn push_front(&mut self, item: T) {
        self.left.push_front(item);
        self.rebalance();
    }

    fn push_middle(&mut self, item: T) {
        if self.left.len() > self.right.len() {
            self.right.push_front(item);
        } else {
            self.left.push_back(item);
        }
    }

    fn get(&self, i: usize) -> &T {
        if i >= self.left.len() {
            &self.right[i - self.left.len()]
        } else {
            &self.left[i]
        }
    }

    fn rebalance(&mut self) {
        if self.left.len() > self.right.len() + 1 {
            self.right.push_front(self.left.pop_back().unwrap())
        } else if self.left.len() < self.right.len() {
            self.left.push_back(self.right.pop_front().unwrap())
        }
    }
}

sol! {
    fn solution(
        n: usize,
        operations: [[String; 2]; n]
    ) -> Lines<usize> {
        let mut res = vec![];
        let mut queue = Teque::default();
        for [op, m] in operations {
            let m: usize = m.parse().unwrap();
            match op.as_str() {
                "push_back" => queue.push_back(m),
                "push_front" => queue.push_front(m),
                "push_middle" => queue.push_middle(m),
                "get" => res.push(*queue.get(m)),
                _ => {}
            }
        }
        res.into()
    }
}

// @code end
