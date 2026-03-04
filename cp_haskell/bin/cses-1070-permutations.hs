-- Created by Ayush Biswas at 2026/03/03 15:54
-- https://cses.fi/problemset/task/1070

-- @code begin
import Text.Printf (printf)

sol :: Int -> [Int]
sol n = [2, 4 .. n] ++ [1, 3 .. n]

main :: IO ()
main = do
  n <- read <$> getLine
  solution n
  where
    solution n
      | n == 1 = print 1
      | n < 4 = putStrLn "NO SOLUTION"
      | otherwise = mapM_ (printf "%d ") $ sol n

-- @code end