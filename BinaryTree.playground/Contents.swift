/* Given a binary tree, get the average value at each level of the tree

Input:
        4
       / \
      7   9
     / \    \
    10  2    6
         \
          6
         /
        2

Output:
 [4, 8, 6, 6, 2]
*/

class Node {
    let value: Int
    let left: Node?
    let right: Node?

    init(value: Int, left: Node? = nil, right: Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

