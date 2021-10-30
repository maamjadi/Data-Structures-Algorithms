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

    static func isClosing(element value: String.Element) -> Bool {
        return value == "]" || value == ")" || value == "}"
    }
}

// Complete the isBalanced function below.
func isBalanced(_ value: String) -> Bool {
    var mutableValue = value
    var specialCharacterDictionary = [SpecialCharacters: Int]()
    var openedCharacterStack = [SpecialCharacters]()

    while !mutableValue.isEmpty {
        let character = mutableValue.removeFirst()
        let specialCharacter = SpecialCharacters(sign: character)
        let isClosingCharacter = SpecialCharacters.isClosing(element: character)

        if let dictCount = specialCharacterDictionary[specialCharacter] {
            specialCharacterDictionary[specialCharacter] = dictCount + (isClosingCharacter ? -1 : 1)
        } else if isClosingCharacter {
            return false
        } else {
            specialCharacterDictionary[specialCharacter] = 1
        }

        if specialCharacterDictionary[specialCharacter]! < 0 {
            return false
        }

        if isClosingCharacter {
            openedCharacterStack.removeLast()
        } else {
            openedCharacterStack.append(specialCharacter)
        }
    }

    return openedCharacterStack.isEmpty
}


let sampleString = "()[{]}" //true
let sampleString1 = "())([{]}" //false
let sampleString2 = "()[{()[{{}}]}]" //true
let sampleString3 = "(){([{{]}))}" //false

print(isBalanced(sampleString))
print(isBalanced(sampleString1))
print(isBalanced(sampleString2))
print(isBalanced(sampleString3))
