-- Created by Ayush Biswas at 2026/03/02 18:33
-- https://atcoder.jp/contests/abc046/tasks/abc046_a
-- @code begin

import Data.List

main :: IO ()
main = do
  cans :: [Int] <- map read . words <$> getLine
  print $ length . nub $ cans

-- @code end