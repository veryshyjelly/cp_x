// Created by Ayush Biswas at 2026/01/20 14:16
// https://atcoder.jp/contests/abc042/tasks/arc058_a
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::HashSet;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [n, _k]: [usize; 2],
        dks: [u8]
    ) -> usize {
        for i in n.. {
            if digits(i).iter().all(|x| !dks.contains(x)) {
                return i
            }
        }
        0
    }
}

fn digits(i: usize) -> HashSet<u8> {
    (1..)
        .scan(i, |state, _| {
            if *state == 0 {
                None
            } else {
                let r = *state % 10;
                *state = *state / 10;
                Some(r as u8)
            }
        })
        .collect()
}

// @code end
