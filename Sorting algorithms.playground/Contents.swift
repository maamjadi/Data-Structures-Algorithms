import Cocoa

let sampleArray = [5, 1, 0, 10, 9, 8]

extension Array where Element: Comparable {

    /// MARK: - Complexity Time O(n^2)
    func bubbleSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        for i in 0..<(data.count-1) { // 1
            for j in 0..<(data.count-i-1) where areInIncreasingOrder(data[j+1], data[j]) { // 2
                data.swapAt(j, j + 1)
            }
        }
        return data
    }

    /// MARK: - Complexity Time O(n^2)
    func insertionSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        for i in 1..<data.count { // 1
            let key = data[i] // 2
            var j = i - 1

            while j >= 0 && areInIncreasingOrder(key, data[j]) { // 3
                data[j+1] = data[j] // 4

                j -= 1
            }
            data[j+1] = key // 5
        }
        return data
    }

    /// MARK: - Complexity Time O(n^2)
    func selectionSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self

        for i in 0..<(data.count-1) {
            var key = i // 1

            for j in i+1..<data.count where areInIncreasingOrder(data[j], data[key]) { // 2
                key = j
            }

            guard i != key else { continue }

            data.swapAt(i, key) // 3
        }
        return data
    }

    /// MARK: - worst case it performs like bubble, selection and insertion sort, O(n²)
    /// - in the average case it’s like the merge sort, O(nlogn)
    /// - like the merge sort but it uses less space and it’s proven that it works better then it on small data
    func quickSort(_ array: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool)) -> [Element] {
        if array.count < 2 { return array } // 0

        var data = array

        // remove(): O(n)
        let pivot = data.remove(at: 0) // 1
        // filter(): O(n)
        let left = data.filter { areInIncreasingOrder($0, pivot) } // 2
        let right = data.filter { !areInIncreasingOrder($0, pivot) } // 3
        let middle = [pivot]

        return quickSort(left, by: areInIncreasingOrder) + middle + quickSort(right, by: areInIncreasingOrder) // 4
    }

    /// MARK: - Complexity Time O(nlog(n))
    private func merge(left: [Element], right: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var output: [Element] = []

        var mutableLeft = left
        var mutableRight = right
        while mutableLeft.count > 0 && mutableRight.count > 0 {

            if let firstElement = mutableLeft.first, let secondElement = mutableRight.first {

                if !areInIncreasingOrder(firstElement, secondElement) {
                    // append(): O(m) where m is the size of the appending array (in this case O(1))
                    output.append(secondElement)
                    // remove(): O(n)
                    mutableRight.remove(at: 0)
                } else {
                    output.append(firstElement)
                    mutableLeft.remove(at: 0)
                }
            }
        }

        output.append(contentsOf: mutableLeft)
        output.append(contentsOf: mutableRight)

        return output
    }

    private func _emMergeSort(data: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        if data.count < 2 { return data }

        let leftArray = Array(data[..<Int(data.count / 2)]) // 1
        let rightArray = Array(data[Int(data.count / 2)..<data.count]) // 2
        return merge(left: _emMergeSort(data: leftArray, by: areInIncreasingOrder), right: _emMergeSort(data: rightArray, by: areInIncreasingOrder), by: areInIncreasingOrder) // 3
    }

    func emMergeSort(by operation: ((Element, Element) -> Bool) = (<)) -> [Element] {
        let data = self

        return _emMergeSort(data: data, by: operation)
    }
}

/// MARK: - Complexity Time O(n)
/// list of well distributed numbers from M to N, this algorithm can sort this list in a linear time
extension Array where Element == Int {
    func bucketSort(reverse: Bool = false) -> [Element] {
        let data = self

        guard data.count > 0 else { return [] }

        let max = data.max()!
        var buckets = [Int](repeating: 0, count: (max + 1))
        var out = [Int]()

        for i in 0..<data.count {
            buckets[data[i]] += 1
        }

        // enumerated(): O(1) compare to for loop that is O(n)
        buckets.enumerated().forEach { index, value in
            guard value > 0 else { return }

            // append(): O(m) where m is the size of the appending array
            out.append(contentsOf: [Int](repeating: index, count: value))
        }

        // reversed(): O(n)
        return reverse == true ? out.reversed() : out
    }
}
