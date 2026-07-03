-- Created by Ayush Biswas at 2026/03/02 18:47
-- https://atcoder.jp/contests/abc046/tasks/arc062_a

-- @code begin
import Control.Monad (replicateM)

getInts :: IO [Int]
getInts = map read . words <$> getLine

a /#\ b = (a + b - 1) `div` b

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  ratios <- replicateM n getInts
  let res = minimalRatio (head ratios) (tail ratios)
  print res
  where
    minimalRatio [a, b] [] = a + b
    minimalRatio [a, b] ([c, d] : xs) =
      let k = max (a /#\ c) (b /#\ d)
       in minimalRatio [k * c, k * d] xs

-- @code end