-- Created by Ayush Biswas at 2026/03/01 21:05
-- https://atcoder.jp/contests/abc044/tasks/arc060_b

-- @code begin

import Control.Applicative ((<|>))
import Data.List

getInt :: IO Int
getInt = read <$> getLine

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

f :: (Integral t) => t -> t -> t
f b n | n < b = n
f b n = f b (n `div` b) + (n `mod` b)

main :: IO ()
main = do
  n <- getInt
  s <- getInt
  let bs =
        sort $
          filter (>= 2) $
            (n + 1)
              : [2 .. isqrt n]
              ++ [ (n - s) `div` x + 1
                   | x <- [1 .. isqrt n],
                     (n - s) `mod` x == 0
                 ]
  let Just res = find (\b -> f b n == s) bs <|> Just (-1)
  print res

-- @code end