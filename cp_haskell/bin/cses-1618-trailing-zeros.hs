-- Created by Ayush Biswas at 2026/03/04 10:11
-- https://cses.fi/problemset/task/1618

-- @code begin

powInFact :: (Integral t) => t -> t -> t
powInFact 0 _ = 0
powInFact n i = n' + powInFact n' i
  where
    n' = n `div` i

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  print $ powInFact n 5

-- @code end