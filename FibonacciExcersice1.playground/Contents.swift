var memory = [Int: Int]()
private func memoizedFib(_ value: Int) -> Int {
    if value <= 0 {
        return 0
    } else if value == 1 {
        return 1
    } else if let memoizedValue = memory[value] {
        return memoizedValue
    }
    let calculatedValue = memoizedFib(value - 1) + memoizedFib(value - 2)
    memory[value] = calculatedValue
    return calculatedValue
}

func getFibValue(for value: Int) {
    memory = [:]
    print(memoizedFib(value))
}

getFibValue(for: 40)
