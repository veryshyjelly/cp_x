-- Created by Ayush Biswas at 2026/03/02 02:29
-- https://atcoder.jp/contests/abc045/tasks/arc061_a

-- @code begin

import Data.Function (on)
import Data.List

main :: IO ()
main = do
  s <- getLine
  let n = length s
  let res = sum [sumMask s mask | mask <- [1 .. 2 ^ (n - 1)]]
  print res

sumMask :: [Char] -> Int -> Int
sumMask s mask = sum [read (map snd g) | g <- grouped]
  where
    splits = odd <$> iterate (`div` 2) mask
    groupIds = scanl (\g b -> if b then g + 1 else g) 0 splits
    tagged = zip groupIds s
    grouped = groupBy ((==) `on` fst) tagged

-- @code end