-- Created by Ayush Biswas at 2026/03/01 20:15
-- https://atcoder.jp/contests/abc044/tasks/arc060_a

-- @code begin

import Data.Array (array, (!))
import Data.Array qualified as Array

getNums :: IO [Int]
getNums = map read . words <$> getLine

main :: IO ()
main = do
  [n, a] <- getNums
  xs <- (array (0, n - 1) <$> zip [0 ..]) . map (flip (-) a) <$> getNums
  print $ sol xs

sol xs = dp ! (n, 0) - 1 -- empty case subtract
  where
    n = length xs
    dp =
      array
        ((0, -2500), (50, 2500))
        [ ((i, j), dp' i j)
          | i <- [0 .. n],
            j <- [-2500 .. 2500]
        ]

    dp' :: Int -> Int -> Int
    dp' 0 0 = 1
    dp' 0 _ = 0
    dp' i j = dp ! (i - 1, j - xs ! (i - 1)) + dp ! (i - 1, j)

-- @code end