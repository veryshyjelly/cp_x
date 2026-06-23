┌─╴BTree
  |Empty
  |Node {
    Value
    Left
    Right
  }
  Leaf ← Node⟜(Empty Empty◌)
└─╴

# Recursive bfs function
# result ? queue result
BFSinner ← |2 ⍣(
  °⊂ # pop front
  ⊃(
    ⊃[BTree.Node.Left|BTree.Node.Right]
    ▽⊸≡(¬≍BTree.Empty)    # filter out null values
    ˜⊂                    # join in queue
  )(⊂BTree.Node.Value ⊙⋅∘ # insert value in res
  )
  BFSinner # recursive call
)(⇌◌)

# Breadth first traversal
# ? tree
BFS ← ˜BFSinner[]¤ # initialize and call BFSinner

# ? tree
Preorder ← |1 ⍣(
  [] °BTree.Empty
| ⊂⊂⊃(
    [BTree.Node.Value]
  | Preorder BTree.Node.Left
  | Preorder BTree.Node.Right)
)

# ? tree
Inorder ← |1 ⍣(
  [] °BTree.Empty
| ⊂⊂⊃(
    Inorder BTree.Node.Left
  | [BTree.Node.Value]
  | Inorder BTree.Node.Right)
)

# ? tree
Postorder ← |1 ⍣(
  [] °BTree.Empty
| ⊂⊂⊃(
    Postorder BTree.Node.Left
  | Postorder BTree.Node.Right
  | [BTree.Node.Value])
)

x ← BTree.Node 1 (
  BTree.Node 3 (BTree.Leaf 7) (BTree.Leaf 11)
) (BTree.Node 5 (BTree.Leaf 17) BTree.Empty)

"Level Order:"
BFS x

"Preorder:"
Preorder x

"Inorder:"
Inorder x

"Postorder:"
Postorder x

# Computes the height of the given tree
# height ? tree
TreeHeight ← |1 ⍣(
  0 °BTree.Empty
| +1 ↥∩TreeHeight⊃(
    BTree.Node.Left
  | BTree.Node.Right)
)

"Height:"
TreeHeight x

# [height diameter] ? tree
TreeDiameterInn ← |1 ⍣(
  [0 0] °BTree.Empty
| ∩TreeDiameterInn⊃(
    BTree.Node.Left
  | BTree.Node.Right)
  ⊃[+1↥∩⊢          # new height
  | ↥⊃(+1+∩⊢)(↥∩⊣) # new diameter
  ]
)

# Computes the longest distance between any two nodes
# in the given tree
# diameter ? tree
TreeDiameter ← ⊣TreeDiameterInn

"Diameter:"
TreeDiameter x

# Inner function for checking balance tree
# returns the height and the result
# [height isBalanced] ? tree
IsBalancedTreeInn ← |1 ⍣(
  [0 1] °BTree.Empty # height, result
| ∩IsBalancedTreeInn⊃(
    BTree.Node.Left
  | BTree.Node.Right)
  ⊃[+1↥∩⊢           # new height
  | ×⊃(≤1⌵-∩⊢)(×∩⊣) # balance condition
  ]
)

# Checks whether the given tree is balanced or not
# ? tree
IsBalancedTree ← ⊣IsBalancedTreeInn

"IsBalanced:"
IsBalancedTree x

# checks whether the value of each node is the sum
# of it's right subtree and left subtree except for
# leaf nodes
# ? tree
SumTree ← |1 ⍣(
  [0 1] °BTree.Empty
| [⟜(1◌)] ∩(°BTree.Empty)⊃(BTree.Node.Left|BTree.Node.Right|BTree.Node.Value)
| ∩SumTree⊃(BTree.Node.Left|BTree.Node.Right|BTree.Node.Value)
  ⊃[++∩⊢          # new sum
  | ×⊃(=+∩⊢)(×∩⊣) # check sum equality
  ]
)

"Sum Check:"
SumTree x

# list res ? list
ProcessLevel ← (
  ⊃(
    /⊂≡⊃[BTree.Node.Left|BTree.Node.Right]
    ▽⊸≡⍣(1◌BTree.Node.Value|0◌) # filter out empty
  )(□≡BTree.Node.Value)
)

# ? tree
ZigZagTraverse ← (
  ⍢ProcessLevel(±⧻) [∘]
  /◇⊂ ⍜▽(⍚⇌) ◿2°⊏
)

ZigZagTraverse x

# map ? tree map
VerticalTraverse ← (
  ∘◌
)
