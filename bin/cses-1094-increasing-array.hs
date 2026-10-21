-- Created by Ayush Biswas at 2026/03/03 15:46
-- https://cses.fi/problemset/task/1094

-- @code begin

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  xs :: [Int] <- map read . words <$> getLine
  let (_, res) = foldl nextMove (0, 0) xs
  print res
  where
    nextMove (curr, moves) e =
      let mov = max (curr - e) 0
       in (e + mov, moves + mov)

-- @code end