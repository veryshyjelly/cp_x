-- Created by Ayush Biswas at 2026/03/09 10:53
-- https://cses.fi/problemset/task/3419

-- @code begin
import Data.Array (array, (!))
import Data.List
import Data.Set qualified as Set
import Text.Printf (printf)

construct n = [[dp @ (i, j) | j <- [1 .. n]] | i <- [1 .. n]]
  where
    dp = array ((0, 0), (n, n)) [((i, j), cell i j) | i <- [0 .. n], j <- [0 .. n]]

    arr @ id = (\(i, _, _) -> i) $ arr ! id

    cell :: Int -> Int -> (Int, Set.Set Int, Set.Set Int)
    cell 0 _ = (0, Set.empty, Set.empty)
    cell _ 0 = (0, Set.empty, Set.empty)
    cell i j = (v, upSet', leftSet')
      where
        (_, upSet, _) = dp ! (i - 1, j)
        (_, _, leftSet) = dp ! (i, j - 1)
        Just v = find (\x -> x `Set.notMember` upSet && x `Set.notMember` leftSet) [0 ..]
        [upSet', leftSet'] = Set.insert v <$> [upSet, leftSet]

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  let res = construct n
  mapM_ (\row -> mapM_ (printf "%d ") row *> printf "\n") res

-- @code end