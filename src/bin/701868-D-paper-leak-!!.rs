// Created by Ayush Biswas at 2026/07/05 21:17
// https://codeforces.com/gym/701868/problem/D
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        [n, k]: [usize; 2]
    ) -> Lines<String> {
        let mut bit_count = 0;
        let mut set_bits = vec![];
        for i in 0..32 {
            if n & (1 << i) != 0 {
                set_bits.push(i);
                bit_count += 1;
            }
        }
        if k < bit_count {
            return vec!["NO".to_string()].into()
        }

        let mut m = k - bit_count;
        set_bits.reverse();
        let mut res = Vec::with_capacity(k);
        // dbg!(set_bits);
        for bit in set_bits {
            m += 1;
            let x = 1 << bit;
            if m == 1 {
                res.push(x);
                m -= 1;
            } else if x <= m {
                res.append(&mut vec![1; x]);
                m -= x;
            } else {
                let j = 1usize << ((x/m).ilog2() + 1);
                let a = (x - m * (j / 2)) / (j / 2);
                let b  = (m * j - x) / (j / 2);
                res.append(&mut vec![j; a]);
                res.append(&mut vec![j/2; b]);
                m = 0;
            }
        }
        if m != 0 {
            return vec!["NO".to_string()].into();
        }

        res.sort();
        vec![
            "YES".to_string(),
            words_of(res).to_string()
        ].into()
    }
}
// @code end
