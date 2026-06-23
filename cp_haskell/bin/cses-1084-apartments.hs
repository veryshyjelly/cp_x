-- Created by Ayush Biswas at 2026/03/14 10:38
-- https://cses.fi/problemset/task/1084

-- @code begin
import Data.ByteString.Char8 qualified as BS
import Data.List (sort)
import Data.Maybe (mapMaybe)

getInts :: IO [Int]
getInts = mapMaybe (fmap fst . BS.readInt) . BS.words <$> BS.getLine

solve [] _ _ acc = acc
solve _ [] _ acc = acc
solve desired@(x : xs) actual@(y : ys) k acc
  | x < y - k = solve xs actual k acc
  | y < x - k = solve desired ys k acc
  | otherwise = solve xs ys k (acc + 1)

main :: IO ()
main = do
  [n, m, k] <- getInts
  desired <- sort <$> getInts
  actual <- sort <$> getInts
  let res = solve desired actual k 0
  print res

-- @code end
