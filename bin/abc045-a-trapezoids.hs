-- Created by Ayush Biswas at 2026/03/02 01:58
-- https://atcoder.jp/contests/abc045/tasks/abc045_a
-- @code begin

readInt :: IO Int
readInt = read <$> getLine

main :: IO ()
main = do
  a <- readInt
  b <- readInt
  h <- readInt
  print $ (a + b) * h `div` 2

-- @code end