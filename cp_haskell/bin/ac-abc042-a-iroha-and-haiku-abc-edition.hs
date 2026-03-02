-- Created by Ayush Biswas at 2026/03/01 11:14
-- https://atcoder.jp/contests/abc042/tasks/abc042_a

-- @code begin
import Data.List

main :: IO ()
main = do
  abc :: [Int] <- sort . map read . words <$> getLine
  putStrLn $ sol abc
  where
    sol [5, 5, 7] = "YES"
    sol _ = "NO"

-- @code end