-- Created by Ayush Biswas at 2026/03/03 19:02
-- https://cses.fi/problemset/task/1072

-- @code begin

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  let res = sol <$> [1 .. n]
  mapM_ print res
  where
    sol i = (i - 1) * (i ^ 2 * (i + 1) `div` 2 - 4 * (i - 2))

-- @code end