-- Created by Ayush Biswas at 2026/03/01 18:29
-- https://atcoder.jp/contests/abc043/tasks/arc059_a

-- @code begin

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  as :: [Int] <- map read . words <$> getLine
  let mean = sum as `div` n
  let cost' = cost as
  print $ minimum [cost' mean, cost' (mean - 1), cost' (mean + 1)]
  where
    cost as x = sum [(x - y) ^ 2 | y <- as]

-- @code end