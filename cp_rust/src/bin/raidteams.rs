// Created by Ayush Biswas at 2026/05/11 17:19
// https://open.kattis.com/problems/raidteams
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::cmp::Reverse;

struct Player {
    name: String,
    a: usize,
    b: usize,
    c: usize,
}

impl Player {
    fn new(player: [String; 4]) -> Self {
        Player {
            name: player[0].clone(),
            a: player[1].parse().unwrap(),
            b: player[2].parse().unwrap(),
            c: player[3].parse().unwrap(),
        }
    }
}

sol! {
    fn solution(
        n: usize,
        players: [[String; 4]; n]
    ) -> Lines<Words<String>> {
        let players = players.into_iter().map(Player::new).collect_vec();
        let mut taken = vec![false; n];
        let mut res = vec![];
        let mut a = &(0..n).sorted_by_key(|&i|
            (Reverse(players[i].a), &players[i].name)
        ).collect_vec()[..];
        let mut b = &(0..n).sorted_by_key(|&i|
            (Reverse(players[i].b), &players[i].name)
        ).collect_vec()[..];
        let mut c = &(0..n).sorted_by_key(|&i|
            (Reverse(players[i].c), &players[i].name)
        ).collect_vec()[..];

        'outer_loop:
        loop {
            while taken[a[0]] {
                a = &a[1..];
                if a.is_empty() {
                    break 'outer_loop;
                }
            }
            let f = players[a[0]].name.clone();
            taken[a[0]] = true;
            while taken[b[0]] {
                b = &b[1..];
                if b.is_empty() {
                    break 'outer_loop;
                }
            }
            let s = players[b[0]].name.clone();
            taken[b[0]] = true;
            while taken[c[0]] {
                c = &c[1..];
                if c.is_empty() {
                    break 'outer_loop;
                }
            }
            let t = players[c[0]].name.clone();
            taken[c[0]] = true;
            res.push(vec![f, s, t].into_iter().sorted().collect());
        }

        res.into()
    }
}

// @code end
