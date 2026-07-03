-- Created by Ayush Biswas at 2026/03/02 10:15
-- https://atcoder.jp/contests/abc045/tasks/arc061_b

-- @code begin
import Control.Monad (replicateM)
import Data.Map qualified as Map
import Data.Set qualified as Set

getInts :: IO [Int]
getInts = map read . words <$> getLine

countDigits :: [Int] -> Map.Map Int Int
countDigits = foldr (\x m -> Map.insertWith (+) x 1 m) $ Map.fromList (map (,0) [0 .. 9])

main :: IO ()
main = do
  [h, w, n] <- getInts
  painted' <- replicateM n getInts
  let painted = Set.fromList . map (\[a, b] -> (a, b)) $ painted'

  let candidates =
        Set.fromList
          [ (a, b)
            | [px, py] <- painted',
              a <- [px - 1 .. px + 1],
              a >= 2,
              a <= h - 1,
              b <- [py - 1 .. py + 1],
              b >= 2,
              b <= w - 1
          ]

      blackCount :: Int -> Int -> Int
      blackCount a b =
        sum
          [1 | x <- [a - 1 .. a + 1], y <- [b - 1 .. b + 1], (x, y) `Set.member` painted]

      counts = uncurry blackCount <$> Set.toList candidates
      countMap = countDigits counts

      totalRec = (h - 2) * (w - 2)
      nonZeroCount = length candidates
      zerCount = totalRec - nonZeroCount

      countMap' = Map.insertWith (+) 0 zerCount countMap
      res = map (countMap' Map.!) [0 .. 9]

  mapM_ print res

-- @code end