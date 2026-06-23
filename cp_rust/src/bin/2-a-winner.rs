// Created by Ayush Biswas at 2026/05/22 21:35
// https://codeforces.com/problemset/problem/2/A
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::{HashMap, HashSet};
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        n: usize,
        scores: [[String; 2]; n]
    ) -> String {
        let players: HashSet<String> = scores
            .iter().map(|x| x[0].to_string()).collect();
        let mut score_board: HashMap<String, Vec<isize>> = players
            .iter().map(|v| (v.to_string(), vec![0isize; n])).collect();
        score_board.get_mut(&scores[0][0]).unwrap()[0] = scores[0][1].parse().unwrap();
        for i in 1..n {
            for p in &players {
                score_board.get_mut(p).unwrap()[i] = score_board[p][i - 1];
            }
            score_board.get_mut(&scores[i][0]).unwrap()[i] += scores[i][1].parse::<isize>().unwrap();
        }

        let mut max_score = 0;
        let mut winners = vec![];
        for p in &players {
            let score = score_board[p][n - 1];
            if score > max_score {
                max_score = score;
                winners = vec![p.to_string()];
            } else if score == max_score {
                winners.push(p.to_string());
            }
        }

        if winners.len() == 1 {
            return winners[0].to_string();
        }

        for i in 0..n {
            for p in &winners {
                if score_board[p][i] >= max_score {
                    return p.to_string();
                }
            }
        }

        "FUCK".into()
    }
}

// @code end
