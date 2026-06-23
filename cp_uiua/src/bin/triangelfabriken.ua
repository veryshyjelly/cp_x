# Created by Ayush Biswas at 2026/03/31 10:08
# https://open.kattis.com/problems/triangelfabriken

ReadInt ← (⋕ &sc)

Sol ← (
  /↥⍥ReadInt3 # get the maximum angle
  /+⊃[=90|≤90]
  ⨬("Trubbig Triangel"|"Spetsig Triangel"|"Ratvinklig Triangel")
)

&p Sol
