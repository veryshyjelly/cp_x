// Created by Ayush Biswas at 2025/07/23 18:15
// https://cses.fi/problemset/task/1145
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        _n: usize,
        a: [usize]
    ) -> usize {
        let mut lis = vec![];

        for ai in a {
            let point = lis.partition_point(|&l| l < ai);
            if point == lis.len() {
                lis.push(ai);
            } else {
                lis[point] = ai;
            }
        }

        lis.len()
    }
}
// @code end
