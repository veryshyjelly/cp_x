-- Created by Ayush Biswas at 2026/03/04 09:50
-- https://cses.fi/problemset/task/1092
-- @code begin

import Control.Monad (when)
import Text.Printf (printf)

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  let divisible = even (sumN n)
  putStrLn $ if divisible then "YES" else "NO"
  when divisible $ printRes n
  where
    sumN n = n * (n + 1) `div` 2

    divide curr required acc =
      if required > curr
        then divide (curr - 1) (required - curr) (curr : acc)
        else (left, right)
      where
        left = [x | x <- [1 .. curr], x /= required]
        right = required : acc

    printRes n = do
      let (l, r) = divide n (n * (n + 1) `div` 4) []
      print $ length l
      mapM_ (printf "%d ") l
      printf "\n"
      print $ length r
      mapM_ (printf "%d ") r

-- @code end