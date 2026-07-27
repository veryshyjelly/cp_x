use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        s: Chars
    ) -> String {
        s.iter().sorted().collect()
    }
}
