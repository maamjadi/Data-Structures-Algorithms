

// Example: remove the zeros from string

let sampleString = "0000012412"

func test1(value: String) -> String {
    var stringIterator = sampleString.makeIterator()
    var zeroCount = 0
    while let character = stringIterator.next() {
        if character != "0" {
            break
        }
        zeroCount += 1
    }
    return String(sampleString.dropFirst(zeroCount))
}

func test2(value: String) -> String {
    if value.starts(with: "0") {
        if value.count < 2 {
            return ""
        }
        let index = value.index(value.endIndex, offsetBy: -(value.count - 1))
        let substring = String(value.suffix(from: index))
        let newString = test2(value: substring)
        return newString
    }
    return value
}
print(test1(value: sampleString))
print(test2(value: sampleString))
