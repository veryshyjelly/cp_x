// Created by Ayush Biswas at 2026/05/09 17:19
// https://open.kattis.com/problems/basicprogramming2
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::collections::HashSet;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [n, t]: [usize; 2],
        a: [usize]
    ) -> String {
        match t {
            1 => two_sum(a),
            2 => is_unique(a),
            3 => majority(a),
            4 => median(a),
            5 => three_digit(a),
            _ => "ERROR".into()
        }
    }
}

fn two_sum(a: Vec<usize>) -> String {
    let mut seen = HashSet::new();
    for ai in a {
        if ai <= 7777 && seen.contains(&(7777 - ai)) {
            return "Yes".into();
        }
        seen.insert(ai);
    }
    "No".into()
}

fn is_unique(a: Vec<usize>) -> String {
    if a.len() == a.iter().unique().count() {
        "Unique".into()
    } else {
        "Contains Duplicate".into()
    }
}

fn majority(mut a: Vec<usize>) -> String {
    a.sort();
    let n = a.len();
    if n == 1 {
        return a[0].to_string();
    }
    if a[(n - 1) / 2] == a[n - 1] {
        a[n - 1].to_string()
    } else if a[n / 2] == a[0] {
        a[0].to_string()
    } else {
        "-1".into()
    }
}

fn median(mut a: Vec<usize>) -> String {
    a.sort();
    let n = a.len();
    let mid = n / 2;
    if n % 2 == 0 {
        format!("{} {}", a[mid - 1], a[mid])
    } else {
        a[mid].to_string()
    }
}

fn three_digit(a: Vec<usize>) -> String {
    a
        .into_iter()
        .sorted()
        .filter(|ai| (100..=999usize).contains(ai))
        .map(|ai| ai.to_string())
        .collect_vec()
        .join(" ")
}
// @code end
