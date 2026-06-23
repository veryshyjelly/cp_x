# Created by Ayush Biswas at 2026/03/30 21:20
# https://open.kattis.com/problems/spritt

ReadInt ← (⋕ &sc)
ReadInts ← (
  &sc
  ⋕ °/$"_ _"
)

Sol ← (
  °⊟ReadInts            # read n, m
  /+⍥ReadInt            # readInt n times, then sum it up
  ˜⊡ {"Jebb" "Neibb"} < # compare and select the result
)

&p Sol # print the result
