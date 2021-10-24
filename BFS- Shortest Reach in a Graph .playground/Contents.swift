import Foundation

//https://www.hackerrank.com/challenges/ctci-bfs-shortest-reach/problem

func getShortestPathValues(for startingIndex: Int, with numberOfNodes: Int, edgesArray: [[Int]]) -> [Int] {

    var shortestPathsArray: Array<Int> = Array(repeating: Int.max, count: numberOfNodes)
    var calculatedNodes: Array<Bool> = Array(repeating: false, count: shortestPathsArray.count)

    shortestPathsArray[startingIndex] = 0

    (0..<numberOfNodes - 1).forEach { _ in

        var minDistance = Int.max
        var selectedIndex = startingIndex
        for index in 0..<numberOfNodes {
            if !calculatedNodes[index] && shortestPathsArray[index] <= minDistance {
                minDistance = shortestPathsArray[index]
                selectedIndex = index
            }
        }

        calculatedNodes[selectedIndex] = true
        let selectedShortestPath = shortestPathsArray[selectedIndex]

        for index in 0..<numberOfNodes {

            if (!calculatedNodes[index]
                && IsEdgeExist(between: selectedIndex, and: index, in: edgesArray)
                && selectedShortestPath != Int.max
                && selectedShortestPath + 1 < shortestPathsArray[index]) {
                shortestPathsArray[index] = selectedShortestPath + 1
            }
        }
    }

    return shortestPathsArray
}

func IsEdgeExist(between firstNode: Int, and secondNode: Int, in edgeArray: [[Int]]) -> Bool {
    return edgeArray.contains(where: { $0.sorted() == [firstNode+1, secondNode+1].sorted() })
}

func printResults(for startingNode: Int, with shortestPathValues: [Int]) {

    for (index, value) in shortestPathValues.enumerated() where index != (startingNode-1) {

        let result = value == Int.max ? -1 : (value * 6)
        print("\(result) ", terminator:"")
    }
}

func calculateShortedPaths() {
    if let queriesString = readLine(), let queries = Int(queriesString) {
        for _ in (0..<queries) {
            var startingNode = 0

            if let NodesEdgesArray = readLine()?.components(separatedBy: " ") {
                let numberOfNodes = Int(NodesEdgesArray[0]) ?? 0
                let numberOfEdges = Int(NodesEdgesArray[1]) ?? 0

                var edgesArray = [[Int]]()
                for _ in (0..<numberOfEdges) {
                    if let edgeString = readLine()?.components(separatedBy: " ") {
                        let edge = edgeString.compactMap({ Int($0) })
                        edgesArray.append(edge)
                    } else { break }
                }

                if let startingNodeString = readLine() {
                    startingNode = Int(startingNodeString) ?? 0
                }

                let shortestPathValues = getShortestPathValues(for: (startingNode-1), with: numberOfNodes, edgesArray: edgesArray)
                printResults(for: startingNode, with: shortestPathValues)

                print("")
            }
        }
    }
}

calculateShortedPaths()
