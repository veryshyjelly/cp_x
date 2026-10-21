-- Created by Ayush Biswas at 2026/03/01 11:53
-- https://atcoder.jp/contests/abc042/tasks/abc042_b

-- @code begin

import Control.Monad (replicateM)
import Data.List

main :: IO ()
main = do
  [n, l] :: [Int] <- map read . words <$> getLine
  x <- concat . sort <$> replicateM n getLine
  putStrLn x

-- @code end