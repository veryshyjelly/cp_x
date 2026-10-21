-- Created by Ayush Biswas at 2026/03/11 19:26
-- https://cses.fi/problemset/task/1621

-- @code begin

import Data.ByteString.Char8 qualified as BS
import Data.Maybe (mapMaybe)
import Data.Set qualified as Set

getInts :: IO [Int]
getInts = mapMaybe (fmap fst . BS.readInt) . BS.words <$> BS.getLine

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  xs :: [Int] <- getInts
  let res = length $ Set.fromList xs
  print res

-- @code end