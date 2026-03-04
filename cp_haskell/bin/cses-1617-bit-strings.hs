-- Created by Ayush Biswas at 2026/03/04 10:07
-- https://cses.fi/problemset/task/1617
-- @code begin

m :: Integer
m = 10 ^ 9 + 7

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  let res = (2 ^ n) `mod` m
  print res

-- @code end