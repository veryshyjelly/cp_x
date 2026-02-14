// Created by Ayush Biswas at 2025/11/16 20:42
// https://codeforces.com/contest/2166/problem/E

#![allow(unused_parens)]

use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::BinaryHeap;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [_n, q]: [usize; 2],
        (mut a): [usize],
        queries: [usize]; q
    ) -> Lines<usize> {
        a.sort();
        a.reverse();
        let amax = a[0];
        let heap: BinaryHeap<usize> = a.into_iter().take(34).collect();
        let mut res = vec![];
        for c in queries {
            if c <= amax {
                res.push(0);
                continue;
            }
            let mut heap = heap.clone();
            let mut mask = 1 << 30;
            let mut r = 0;
            while mask > 0 {
                if c & mask > 0 {
                    let ai = heap.pop().unwrap();
                    if mask >= ai {
                        r += mask - ai;
                        heap.push(0);
                    } else if mask < ai {
                        heap.push(ai ^ mask);
                    } else if mask * 2 <= ai {
                        break;
                    }
                }
                mask >>= 1;
            }
            res.push(r);
        }
        res.into()
    }
}

// @code end
