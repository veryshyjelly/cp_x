-- Created by Ayush Biswas at 2026/03/09 11:38
-- https://cses.fi/problemset/task/3217

-- @code begin

import Control.Monad (filterM)
import Control.Monad.ST
import Data.Array ((!))
import Data.Array.ST
import Data.ByteString.Char8 qualified as BS
import Data.Sequence
import System.IO (stdout)

horseMoves :: [(Int, Int)]
horseMoves = [(2, 1), (2, -1), (-2, 1), (-2, -1), (1, 2), (-1, 2), (1, -2), (-1, -2)]

neighbors :: (Int, Int) -> [(Int, Int)]
neighbors (x, y) = [(dx + x, dy + y) | (dx, dy) <- horseMoves]

movesGrid :: Int -> [[Int]]
movesGrid n = runST $ do
  grid <- newArray ((0, 0), (n - 1, n - 1)) (-1) :: ST s (STArray s (Int, Int) Int)
  writeArray grid (0, 0) 0
  bfs (singleton (0, 0)) grid
  arr <- freeze grid
  return [[arr ! (i, j) | j <- [0 .. n - 1]] | i <- [0 .. n - 1]]
  where
    isValid cell@(x, y) grid = do
      if x >= 0 && y >= 0 && x < n && y < n
        then (== -1) <$> readArray grid cell
        else return False

    bfs Empty _ = return ()
    bfs ((x, y) :<| rest) grid = do
      d <- readArray grid (x, y)
      next <- filterM (`isValid` grid) $ neighbors (x, y)
      mapM_ (\cell -> writeArray grid cell (d + 1)) next
      bfs (rest >< fromList next) grid

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  let arr = BS.unlines (BS.unwords . map (BS.pack . show) <$> movesGrid n)
  BS.hPutStrLn stdout arr

-- @code end