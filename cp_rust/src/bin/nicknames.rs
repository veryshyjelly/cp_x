// Created by Ayush Biswas at 2026/05/06 20:13
// https://open.kattis.com/problems/nicknames
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::collections::HashMap;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

#[derive(Default)]
struct Trie {
    size: usize,
    child: HashMap<char, Trie>,
}

impl Trie {
    fn insert(&mut self, s: &[char]) {
        if s.is_empty() {
            return;
        }
        if !self.child.contains_key(&s[0]) {
            self.child.insert(s[0], Trie::default());
        }
        let c = self.child.get_mut(&s[0]).unwrap();
        c.size += 1;
        c.insert(&s[1..]);
    }

    fn query(&self, s: &[char]) -> usize {
        if s.is_empty() {
            return self.size;
        }
        if let Some(c) = self.child.get(&s[0]) {
            return c.query(&s[1..]);
        }
        0
    }
}

sol! {
    fn solution(
        n: usize,
        names: [[char]; n],
        m: usize,
        nicknames: [[char]; m]
    ) -> Lines<usize> {
        let mut trie = Trie::default();
        for name in names {
            trie.insert(&name);
        }
        nicknames
            .into_iter()
            .map(|nickname| trie.query(&nickname))
            .collect_vec()
            .into()
    }
}

// @code end
