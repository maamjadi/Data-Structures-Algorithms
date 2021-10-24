import Foundation

//https://www.hackerrank.com/challenges/balanced-brackets/problem

enum BalanceCases: String {
    case yes, no

    var value: String { return self.rawValue.uppercased() }
}

enum SpecialCharacters: String {
    case brackets = "["
    case parenthesis = "("
    case braces = "{"
    case none

    init(sign: String.Element) {
        if sign == "]" {
            self = .brackets
        } else if sign == ")" {
            self = .parenthesis
        } else if sign == "}" {
            self = .braces
        } else {
            self = SpecialCharacters(rawValue: String(sign)) ?? .none
        }
    }

    static func isClosingString(for value: String.Element) -> Bool {
        return value == "]" || value == ")" || value == "}"
    }
}

// Complete the isBalanced function below.
func isBalanced(s: String) -> String {
    var isBalanced: BalanceCases = .yes
    var baracketBalanceDic = [SpecialCharacters: Int]()
    var openedCharacterStack = [SpecialCharacters]()

    for character in s {
        let specialCharacter = SpecialCharacters(sign: character)
        guard specialCharacter != .none else { return BalanceCases.no.value }

        let isClosingString = SpecialCharacters.isClosingString(for: character)

        if let repeatedNumber = baracketBalanceDic[specialCharacter] {
            baracketBalanceDic[specialCharacter] = repeatedNumber + (isClosingString ? -1 : 1)
        } else {
            baracketBalanceDic[specialCharacter] = 1
        }

        if baracketBalanceDic[specialCharacter]! < 0 || (isClosingString && (openedCharacterStack.last ?? specialCharacter != specialCharacter)) { return BalanceCases.no.value }

        if isClosingString {
            openedCharacterStack.removeLast()
        } else {
            openedCharacterStack.append(specialCharacter)
        }
    }

    for value in baracketBalanceDic.values where value != 0 {
        isBalanced = .no
    }
    
    return isBalanced.value
}

let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let t = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    else { fatalError("Bad input") }

for tItr in 1...t {
    guard let s = readLine() else { fatalError("Bad input") }

    let result = isBalanced(s: s)

    fileHandle.write(result.data(using: .utf8)!)
    fileHandle.write("\n".data(using: .utf8)!)
}
