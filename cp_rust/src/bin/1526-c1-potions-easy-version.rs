// Created by Ayush Biswas at 2026/05/23 10:24
// https://codeforces.com/problemset/problem/1526/C1
use cp_lib::*;

// @code begin
use cpio::*;
use std::cmp::Reverse;
use std::collections::BinaryHeap;

sol! {
    fn solution(
        n: usize,
        a: [isize]
    ) -> usize {
        let mut heap: BinaryHeap<Reverse<isize>> = BinaryHeap::new(); // min-heap
        let mut sum = 0isize;
    
        for ai in a {
            heap.push(Reverse(ai));
            sum += ai;
    
            // Sum went negative: evict the element that hurt us most
            if sum < 0 {
                let Reverse(min_val) = heap.pop().unwrap();
                sum -= min_val; // undo its contribution
            }
        }
    
        heap.len()
    }
}

// @code end
