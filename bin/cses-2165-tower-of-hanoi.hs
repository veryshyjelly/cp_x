-- Created by Ayush Biswas at 2026/03/04 21:06
-- https://cses.fi/problemset/task/2165

-- @code begin
import Text.Printf (printf)

tower :: Int -> Int -> Int -> Int -> [[Int]]
tower 0 _ _ _ = []
tower n s d a =
  tower (n - 1) s a d ++ [[s, d]] ++ tower (n - 1) a d s

printMatrix :: [[Int]] -> IO ()
printMatrix = mapM_ (\row -> mapM (printf "%d ") row *> printf "\n")

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  let res = tower n 1 3 2
  print $ length res
  printMatrix res

-- @code end