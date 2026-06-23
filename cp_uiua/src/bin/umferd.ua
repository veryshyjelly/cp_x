# Created by Ayush Biswas at 2026/03/31 09:47
# https://open.kattis.com/problems/umferd

ReadInt ← (⋕ &sc)
ReadInts ← (
  &sc
  ⋕ °/$"_ _"
)

CountEmptyCells ← (
  /+ =@. &sc
)

Sol ← (
  ReadInt # m
  ReadInt # n
  ⟜×      # n (n * m)
  /+ ⍥CountEmptyCells
  ˜÷ # get the ratio
)

&p Sol
