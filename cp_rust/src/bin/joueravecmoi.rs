// Created by Ayush Biswas at 2026/05/09 22:51
// https://open.kattis.com/problems/joueravecmoi
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
const INF: isize = 4 * 10isize.pow(18);

sol! {
    fn solution(
        n: usize,
        excitements: [[i128; 2]; n]
    ) -> Words<i128> {
        let pairs  = (0..n)
        .filter(|i| i % 2 == 0)
        .map(|i| {
            (i, i ^ 1)
        }).collect_vec();

        let singles = pairs.iter().map(|(a, b)| {
            excitements[*a][1].max(excitements[*b][1])
        });
        let gains  = pairs.iter().map(|(a, b)| {
            (excitements[*a][0] + excitements[*b][0]) - excitements[*a][1].max(excitements[*b][1])
        });

        singles.chain(gains)
        .sorted_by(|a, b| b.cmp(a))
        .scan(0, |acc, x| {
            *acc += x;
            Some(*acc)
        }).collect_vec().into()
    }
}

// @code end
