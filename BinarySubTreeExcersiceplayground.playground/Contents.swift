/* Given two binary trees T1 & T2, write algorithm to determine if T2 is a subtree of T1
 */

class Node: Equatable {

    let value: Int
    let left: Node?
    let right: Node?

    init(value: Int, left: Node? = nil, right: Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.value == rhs.value && lhs.right == rhs.right && lhs.left == rhs.left
    }
}

let node6 = Node(value: 6, left: Node(value: 2))
let node2 = Node(value: 2, right: node6)
let node7 = Node(value: 7, left: Node(value: 10), right: node2)
let node9 = Node(value: 9, right: Node(value: 6))
let node22 = Node(value: 2, right: node9)
let T1 = Node(value: 4, left: node7, right: node9)

let T2 = node2 

private func _checkSubTree(for tree: Node?, checkTree: Node?, returnValue: inout Bool) {

    guard let checkTree = checkTree,
          let tree = tree,
          !returnValue else {
              return
          }

    if tree == checkTree {
        returnValue = true
    } else {
        _checkSubTree(for: tree.left, checkTree: checkTree, returnValue: &returnValue)
        _checkSubTree(for: tree.right, checkTree: checkTree, returnValue: &returnValue)
    }
}

func checkSubTree() -> Bool {
    var result = false
    _checkSubTree(for: T1, checkTree: T2, returnValue: &result)
    return result
}

print(checkSubTree())
