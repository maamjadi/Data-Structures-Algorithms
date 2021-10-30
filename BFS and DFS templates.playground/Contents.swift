struct SimpleTree {
    var value : Int
    var children : [SimpleTree]?
}

var simpleNode = SimpleTree(value: 2, children: [SimpleTree(value: 5, children: nil), SimpleTree(value: 6, children: nil)])
var simpleRoot = SimpleTree(value: 1, children: [simpleNode,
                                                 SimpleTree(value: 4, children: nil),
                                                 SimpleTree(value: 3, children: [SimpleTree(value: 12, children: nil)])])

/// Breadth-first search
/// eg. shortest path algorithm
/// When we think the data we're looking for lives somewhere near the top
func resolveBFS(_ tree: SimpleTree) -> [Int] {

    var result = [Int]()
    var queueTree = [tree]

    while !queueTree.isEmpty {

        let current = queueTree.remove(at: 0) // FIFO - remove the first entry
        result.append(current.value) // process node
        if let children = current.children {
            for tree in children {
                queueTree.append(tree)
            }
        }
    }

    return result
}

print(resolveBFS(simpleRoot).debugDescription, "BFS")

/// Depth-first search
/// eg. maze problems
/// When we want to go deep. thinking that the data we're looking for lives deep down the binary tree
func resolveDFS(_ tree: SimpleTree) -> [Int] {

    var result = [Int]()
    var stackTree = [tree]

    while !stackTree.isEmpty {

        let current = stackTree.popLast() // remove the last one added, O(1)
        guard let currentUnwrap = current else { return result }
        result.append(currentUnwrap.value) // process node
        if let children = currentUnwrap.children {
            for tree in children {
                stackTree.append(tree)
            }
        }
    }

    return result
}

print(resolveDFS(simpleRoot).debugDescription, "DFS")
