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

let node6 = Node(value: 6, left: Node(value: 2))
let node2 = Node(value: 2, right: node6)
let node7 = Node(value: 7, left: Node(value: 10), right: node2)
let node9 = Node(value: 9, right: Node(value: 6))
let root = Node(value: 4, left: node7, right: node9)

private func archive(_ node: Node?, data: inout [Int: (sum: Int, count: Int)], depth: Int = 0) {

    guard let node = node else {
        return
    }

    if let value = data[depth] {
        let newSum = value.sum + node.value
        let newCount = value.count + 1
        data[depth] = (newSum, newCount)
    } else {
        data[depth] = (node.value, 1)
    }

    archive(node.left, data: &data, depth: depth + 1)
    archive(node.right, data: &data, depth: depth + 1)
}

func getAveragePerDepth(for node: Node) -> [Int: Int] {

    var result = [Int: (sum: Int, count: Int)]()
    archive(node, data: &result)

    return result.compactMapValues({ $0.sum / $0.count })
}

getAveragePerDepth(for: root)


