-- Created by Ayush Biswas at 2026/03/11 08:18
-- https://cses.fi/problemset/task/3311

-- @code begin
import Control.Monad (replicateM)

colorIt :: [String] -> [String]
colorIt = colorGrid
  where
    colorGrid = zipWith colorRow [1 ..]
    colorRow i = zipWith (colorCell i) [1 ..]

    colorCell i j c
      | even (i + j) = if c == 'A' then 'C' else 'A'
      | otherwise = if c == 'B' then 'D' else 'B'

main :: IO ()
main = do
  [h, w] :: [Int] <- map read . words <$> getLine
  grid <- colorIt <$> replicateM h getLine
  mapM_ putStrLn grid

-- @code end