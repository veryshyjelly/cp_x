// Created by Ayush Biswas at 2026/07/07 22:55
// https://atcoder.jp/contests/adt_easy_20260212_1/tasks/abc439_b
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::HashSet;

fn digits(mut n: usize) -> Vec<usize> {
    let mut res = vec![];
    while n > 0 {
        res.push(n % 10);
        n /= 10;
    }
    res
}

sol! {
    fn solution(
        n: usize,
    ) -> Bool {
        let reduce = |l: usize| digits(l).into_iter().map(|x| x*x).sum::<usize>();
        let mut seen: HashSet<usize> = HashSet::new();
        let mut m = n;
        while m != 1 {
            seen.insert(m);
            m = reduce(m);
            if seen.contains(&m) {
                return false.into();
            }
        }
        true.into()
    }
}
// @code end
