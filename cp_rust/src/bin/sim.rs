// Created by Ayush Biswas at 2026/05/10 17:11
// https://open.kattis.com/problems/sim
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::VecDeque;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

#[derive(Default)]
struct Keyboard {
    left: VecDeque<char>,
    right: VecDeque<char>,
}

impl Keyboard {
    fn insert(&mut self, c: char) {
        self.left.push_back(c);
    }

    fn backspace(&mut self) {
        self.left.pop_back();
    }

    fn home(&mut self) {
        if self.right.len() < self.left.len() {
            while let Some(c) = self.right.pop_front() {
                self.left.push_back(c);
            }
            std::mem::swap(&mut self.left, &mut self.right);
        } else {
            while let Some(c) = self.left.pop_back() {
                self.right.push_front(c);
            }
        }
    }

    fn end(&mut self) {
        if self.right.len() < self.left.len() {
            while let Some(c) = self.right.pop_front() {
                self.left.push_back(c);
            }
        } else {
            while let Some(c) = self.left.pop_back() {
                self.right.push_front(c);
            }
            std::mem::swap(&mut self.left, &mut self.right);
        }
    }

    fn to_string(mut self) -> String {
        self.left.append(&mut self.right);
        self.left.into_iter().collect()
    }
}

sol_n! {
    fn solution(
        s: [char]
    ) -> String {
        let mut board = Keyboard::default();
        for c in s {
            if c == '<' {
                board.backspace();
            } else if c == '[' {
                board.home();
            } else if c == ']' {
                board.end();
            } else {
                board.insert(c);
            }
        }
        board.to_string()
    }
}

// @code end
