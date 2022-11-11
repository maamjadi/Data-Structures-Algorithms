import Foundation

// MARK: - Remove the zeros from string

let removeZerosString = "0000012412"

///my way
func removeZeros1(value: String) -> String {
    var stringIterator = value.makeIterator()
    var zeroCount = 0
    while let character = stringIterator.next() {
        if character != "0" {
            break
        }
        zeroCount += 1
    }
    return String(value.dropFirst(zeroCount))
}


///recursive way
func removeZeros2(value: String) -> String {
    if value.starts(with: "0") {
        if value.count < 2 {
            return ""
        }
        let index = value.index(value.endIndex, offsetBy: -(value.count - 1))
        let substring = String(value.suffix(from: index))
        let newString = removeZeros2(value: substring)
        return newString
    }
    return value
}

print("removeZeros-----------")
print(removeZeros1(value: removeZerosString))
print(removeZeros2(value: removeZerosString))
print("----------------------")


// MARK: - Given a string, make sure it only contains unique characters

let uniqueCharactersString1 = "abcAde"
let uniqueCharactersString2 = "abcade"
let uniqueCharactersString3 = "abcde32o"
let uniqueCharactersString4 = "😘😜"
let uniqueCharactersString5 = "😘😘"

///my way
func isContainingUniqueCharacters1(value: String) -> Bool {
    var charactersDict = [Character: Bool]()
    var stringIterator = value.makeIterator()

    while let character = stringIterator.next() {
        if charactersDict[character] == nil {
            charactersDict[character] = true
        } else {
            return false
        }
    }
    return true
}

print("uniqueCharacters------")
print(isContainingUniqueCharacters1(value: uniqueCharactersString1))
print(isContainingUniqueCharacters1(value: uniqueCharactersString2))
print(isContainingUniqueCharacters1(value: uniqueCharactersString3))
print(isContainingUniqueCharacters1(value: uniqueCharactersString4))
print(isContainingUniqueCharacters1(value: uniqueCharactersString5))
print("----------------------")


// MARK: - Given two strings, check if 1 is permutation of the other

let permutationString1 = "abc304"
let permutationStringCheck1 = "403cba"
let permutationStringCheck2 = "403abc"
let permutationStringCheck3 = "403cb"

///my way
/// O(n^2)
func isReversedFound1(for value: String, checkValue: String) -> Bool {
    var mutableValue = value
    var mutableCheckValue = checkValue

    guard value.count == checkValue.count else {
        return false
    }

    for _ in (0..<value.count) {
        //Complexity of removeFirst() is O(n)
        //Complexity of removeLast() is O(1)
        if mutableValue.removeFirst() != mutableCheckValue.removeLast() {
            return false
        }
    }
    return true
}

///my way
/// O(n+m): n = value.count, m = checkValue.count
func isReversedFound2(for value: String, checkValue: String) -> Bool {
    var stack = [Character]()

    guard value.count == checkValue.count else {
        return false
    }

    value.forEach { character in
        stack.append(character)
    }
    for character in Array(checkValue) {
        let last = stack.popLast()
        if last != character {
            return false
        }
    }
    return true
}

///my way
/// O(n)
func isReversedFound3(for value: String, checkValue: String) -> Bool {
    var mutableCheckValue = checkValue

    guard value.count == checkValue.count else {
        return false
    }

    for character in Array(value) {
        if character != mutableCheckValue.removeLast() {
            return false
        }
    }
    return true
}

/// .sorted() has complexity time of O(n*logn) and uses pivot quick sort
func isPermutationFound2(for value: String, checkValue: String) -> Bool {
    guard value.count == checkValue.count else {
        return false
    }

    return value.sorted(by: <) == checkValue.sorted(by: <)
}

print("reverse---------------")
print(isReversedFound1(for: permutationString1, checkValue: permutationStringCheck1))
print(isReversedFound1(for: permutationString1, checkValue: permutationStringCheck2))
print(isReversedFound1(for: permutationString1, checkValue: permutationStringCheck3))
print("-----------")
print(isReversedFound2(for: permutationString1, checkValue: permutationStringCheck1))
print(isReversedFound2(for: permutationString1, checkValue: permutationStringCheck2))
print(isReversedFound2(for: permutationString1, checkValue: permutationStringCheck3))
print("-----------")
print(isReversedFound3(for: permutationString1, checkValue: permutationStringCheck1))
print(isReversedFound3(for: permutationString1, checkValue: permutationStringCheck2))
print(isReversedFound3(for: permutationString1, checkValue: permutationStringCheck3))
print("permutation-----------")
print(isPermutationFound2(for: permutationString1, checkValue: permutationStringCheck1))
print(isPermutationFound2(for: permutationString1, checkValue: permutationStringCheck2))
print(isPermutationFound2(for: permutationString1, checkValue: permutationStringCheck3))
print("----------------------")


// MARK: - replace all the spaces in the string with ASCII symbol for space (%20)

let urlIfyString = "MY Home page20     " //MY%20Home%20page20

/// my way
/// O(n+m)
func urlIfy1(value: String) -> String {
    return value.trimmingCharacters(in: [" "]).replacingOccurrences(of: " ", with: "%20")
}

print("URLIfy----------------")
print(urlIfy1(value: urlIfyString))
print("----------------------")


// MARK: - Given two strings, check if they're 1 or 0 edit away (remove, replace, insert)

let oneWayString1 = "pale"
let oneWayCheckString1 = "ple"
let oneWayString2 = "pales"
let oneWayCheckString2 = "pale"
let oneWayString3 = "pale"
let oneWayCheckString3 = "bale"
let oneWayString4 = "pales"
let oneWayCheckString4 = "bae"

private func isOneEditInsert(value: String, checkValue: String) -> Bool {
    let valueArray = Array(value)
    let checkValueArray = Array(checkValue)

    var valueIndex = 0
    var checkValueIndex = 0

    while (valueIndex < valueArray.count) && (checkValueIndex < checkValueArray.count) {
        if valueArray[valueIndex] == checkValueArray[checkValueIndex] {
            valueIndex += 1
            checkValueIndex += 1
        } else {
            if valueIndex != checkValueIndex {
                return false
            }
            checkValueIndex += 1
        }
    }
    return true
}

private func isOneEditReplace(value: String, checkValue: String) -> Bool {
    let valueArray = Array(value)
    let checkValueArray = Array(checkValue)
    var isDifferenceFound = false

    for index in (0..<valueArray.count) {
        if valueArray[index] != checkValueArray[index] {
            if isDifferenceFound {
                return false
            }
            isDifferenceFound = true
        }
    }

    return true
}

func oneWay(value: String, checkValue: String) -> Bool {
    let difference = value.count - checkValue.count

    if difference == 0 {
        return isOneEditReplace(value: value, checkValue: checkValue)
    } else if difference < 0 {
        return isOneEditInsert(value: value, checkValue: checkValue)
    } else {
        return isOneEditInsert(value: checkValue, checkValue: value)
    }
}

print("oneWay----------------")
print(oneWay(value: oneWayString1, checkValue: oneWayCheckString1)) //remove
print(oneWay(value: oneWayString2, checkValue: oneWayCheckString2)) //insert
print(oneWay(value: oneWayString3, checkValue: oneWayCheckString3)) //replace
print(oneWay(value: oneWayString4, checkValue: oneWayCheckString4)) //FALSE
print("----------------------")


// MARK: - Given a string with repeating characters (e.g. aaabb) give compressed string down to the character followed by the number of repeats (if compressed is larger then return the original)

let compressString1 = "aaabbaa"
let compressString2 = "zzzzzzz"
let compressString3 = "a"
let compressString4 = "abcedfgggghh"

struct IndexedString: Hashable {
    let index: Int
    let key: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
        hasher.combine(key)
    }
}

/// my way
func compress1(value: String) -> String {
    guard !value.isEmpty else { return "" }

    var compressedValue = ""
    var currentCharacter: String.Element = Character(" ")
    var counter = 0

    value.forEach { character in
        if character != currentCharacter {
            if currentCharacter != " " {
                compressedValue.append("\(currentCharacter)\(counter)")
            }
            currentCharacter = character
            counter = 1
        } else {
            counter += 1
        }
    }

    compressedValue.append("\(currentCharacter)\(counter)")
    return compressedValue.count > value.count ? value : compressedValue
}

print("oneWay----------------")
print(compress1(value: compressString1))
print(compress1(value: compressString2))
print(compress1(value: compressString3))
print(compress1(value: compressString4))
print("----------------------")
