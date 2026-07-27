// Created by Ayush Biswas at 2026/07/11 21:44
// https://atcoder.jp/contests/adt_easy_20240702_1/tasks/abc355_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        [_n, _m]: [usize; 2],
        a: [usize],
        b: [usize]
    ) -> Bool {
        let a_tagged = a.into_iter().map(|ai| (ai, 1));
        let b_tagged = b.into_iter().map(|bi| (bi, 0));
        a_tagged
            .chain(b_tagged)
            .sorted()
            .map(|(_, tag)| tag)
            .scan(0, |acc, ai| {
                let res = *acc * ai;
                *acc = ai;
                Some(res)
            })
            .any(|m| m == 1).into()
    }
}
// @code end
