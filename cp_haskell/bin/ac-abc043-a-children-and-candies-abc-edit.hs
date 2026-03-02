-- Created by Ayush Biswas at 2026/03/01 14:54
-- https://atcoder.jp/contests/abc043/tasks/abc043_a

-- @code begin

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  print $ n * (n + 1) `div` 2

-- @code end