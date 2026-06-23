# Created by Ayush Biswas at 2026/04/15 14:29
# https://open.kattis.com/problems/bracketmatching

◌&sc

IsOpen ← ∊ "({["

ToClose ← ˜⊡ ")]}" ⨂"([{"

# stack ? bracket stack
ProcessChar ← ⍣(
  ⊂ToClose˙⍤⊸IsOpen # push
)(
  ˙⍤≍⊙(°⊂) # pop
)

Sol ← ⍣(
  ∧ProcessChar
  ˙⍤≍"" # stack should be empty
  "Valid"
)("Invalid"◌)

&p Sol &sc ""
