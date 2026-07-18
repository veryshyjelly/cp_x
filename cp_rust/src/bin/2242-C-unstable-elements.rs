// Created by Ayush Biswas at 2026/07/06 20:45
// https://codeforces.com/contest/2242/problem/C
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::btree_map;

sol_n! {
    fn solution(
        [n, k]: [usize; 2],
        a: [usize]
    ) -> usize {
        let mut map = btree_map::BTreeMap::<usize, usize>::new();
        for ai in a {
            *map.entry(ai).or_insert(0) += 1;
        }
        let mut res = 0;
        let mut total = n;
        let steps = map.len();
        let mut prev_steps = usize::MAX;
        if k >= total && (k - total) % steps == 0 {
            prev_steps = steps;
            res += 1;
        }
        while !map.is_empty() {
            let keys = map.keys().cloned().collect::<Vec<_>>();
            for key in keys {
                let count = map.remove(&key).unwrap();
                if count > 1 {
                    map.insert(key, count - 1);
                }
                total -= 1;
            }
            let steps = map.len();
            if steps == 0 {
                break;
            }
            if steps != prev_steps && k >= total && (k - total) % steps == 0 {
                prev_steps = steps;
                res += 1;
            }
        }
        res
    }
}
// @code end
