-- Created by Ayush Biswas at 2026/03/02 19:08
-- https://atcoder.jp/contests/abc046/tasks/arc062_b

-- @code begin

main :: IO ()
main = do
  moves <- getLine
  let myMoves = cycle "gp"
  let res = uncurry play <$> zip myMoves moves
  print $ sum res
  where
    play 'g' 'p' = -1
    play 'p' 'g' = 1
    play _ _ = 0

-- @code end