// Created by Ayush Biswas at 2026/05/20 10:16
// https://codeforces.com/problemset/problem/550/C
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::HashMap;

sol! {
    fn solution(
        n: String,
    ) -> String {
        let mut places: HashMap<char, Vec<usize>> = ('0'..='9').map(|i| (i, vec![])).collect();
        for (i, digit) in n.chars().enumerate() {
            places.get_mut(&digit).unwrap().push(i + 1);
        }
        if !places[&'0'].is_empty() {
            return "YES\n0".into();
        }

     'number_loop:
        for i in 1..1000 {
            if i%8 != 0 { continue; }
            let mut last_place = 0;

            for digit in i.to_string().chars() {
                let mut c = false;
                for &place in &places[&digit] {
                    if place > last_place {
                        last_place = place;
                        c = true;
                        break;
                    }
                }
                if !c {
                    continue 'number_loop;
                }
            }

            return format!("YES\n{i}");
        }

        "NO".into()
    }
}


// @code end
