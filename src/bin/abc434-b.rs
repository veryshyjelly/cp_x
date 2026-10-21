// Created by Ayush Biswas at 2026/07/27 17:16
// https://atcoder.jp/contests/adt_easy_20260617_1/tasks/abc434_b
// D - Bird Watching

use std::collections::HashMap;

use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: usize, m: usize,
        birds: [[usize; 2]; n]
    ) -> Lines<f64> {
        let averages: HashMap<usize, f64> = birds.into_iter()
            .map(|ab| (ab[0], ab[1]))
            .into_grouping_map()
            .fold((0usize, 0usize), |(count, sum), _k, v| {
                 (count + 1, sum + v)
             })
            .into_iter()
            .map(|(k, v)| (k, v.1 as f64 / v.0 as f64))
            .collect();
        (1..=m).map(|i|
            *averages.get(&i).unwrap_or(&0.0)).collect()
    }
}
