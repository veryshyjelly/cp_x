-- Created by Ayush Biswas at 2026/03/11 10:59
-- https://cses.fi/problemset/task/2431

-- @code begin

import Control.Monad
import Data.List (intersperse)

kthDigit :: Int -> Char
kthDigit k = show number !! digitPos
  where
    ranges = zip [1 ..] (iterate (* 10) 9)

    (width, base, remaining) =
      last . takeWhile (\(_, _, r) -> r > 0) $
        scanl (\(_, b, r) (w, c) -> (w + 1, b + c, r - w * c)) (1, 0, k) ranges

    (idx, digitPos) = (remaining - 1) `divMod` width
    number = base + idx + 1

main :: IO ()
main = do
  q :: Int <- read <$> getLine
  res :: [Char] <- map kthDigit <$> replicateM q (read <$> getLine)
  let x = intersperse '\n' res
  putStrLn x

-- @code end