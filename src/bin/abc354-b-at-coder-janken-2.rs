// Created by Ayush Biswas at 2026/07/11 18:23
// https://atcoder.jp/contests/adt_easy_20240724_2/tasks/abc354_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: usize,
        players: [[String; 2]; n]
    ) -> String {
        let mut names = vec![];
        let mut total_score: usize = 0;
        for [p, s] in players {
            names.push(p);
            total_score += s.parse::<usize>().unwrap();
        }
        names
            .into_iter()
            .sorted()
            .nth(total_score % n)
            .unwrap()
    }
}
// @code end
