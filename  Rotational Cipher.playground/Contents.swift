/*
 Rotational Cipher
 One simple way to encrypt a string is to "rotate" every alphanumeric character by a certain amount. Rotating a character means replacing it with another character that is a certain number of steps away in normal alphabetic or numerical order.
 For example, if the string "Zebra-493?" is rotated 3 places, the resulting string is "Cheud-726?". Every alphabetic character is replaced with the character 3 letters higher (wrapping around from Z to A), and every numeric character replaced with the character 3 digits higher (wrapping around from 9 to 0). Note that the non-alphanumeric characters remain unchanged.
 Given a string and a rotation factor, return an encrypted string.
 Signature
 string rotationalCipher(string input, int rotationFactor)
 Input
 1 <= |input| <= 1,000,000
 0 <= rotationFactor <= 1,000,000
 Output
 Return the result of rotating input a number of times equal to rotationFactor.
 Example 1
 input = Zebra-493?
 rotationFactor = 3
 output = Cheud-726?
 Example 2
 input = abcdefghijklmNOPQRSTUVWXYZ0123456789
 rotationFactor = 39
 output = nopqrstuvwxyzABCDEFGHIJKLM9012345678
 */

import Foundation


let alphabets: [String.Element] = Array("abcdefghijklmnopqrstuvwxyz")


struct RotationalCipher {
    let backing: String

    func cipher(withRotationFactor: Int) -> String {
        var lowercaseCypherKey = [String.Element: String.Element]()
        var resultString = [String.Element]()

        for ctr in (0..<alphabets.count) {
            let key = alphabets[ctr]
            let value = (ctr + withRotationFactor) % 26
            lowercaseCypherKey[key] = alphabets[value]
        }

        Array(backing).forEach { character in
            if let lowerCaseCharacter = Array(character.lowercased()).first,
               let value = lowercaseCypherKey[lowerCaseCharacter] {
                if let upperCaseCharacter = Array(value.uppercased()).first {
                    resultString.append(character.isUppercase ? upperCaseCharacter : value)
                }
            } else if let intValue = Int(String(character)) {
                let value = (intValue + withRotationFactor) % 10
                resultString.append(contentsOf: String(value))
            } else {
                resultString.append(character)
            }
        }

        return String(resultString)

    }
}

// These are the tests we use to determine if the solution is correct.
// You can add your own at the bottom.

private extension String {
    var characterArray: String {
        return "[\"\(self)\"]"
    }
}

private var testCaseNumber = 1;

private extension RotationalCipher {
    static func check(_ expectedValue: String, against output: String) {
        let rightTick = "\u{2713}";
        let wrongTick = "\u{2717}";

        let result = expectedValue == output
        if result {
            print("\(rightTick) Test #\(testCaseNumber)")
        } else {
            print("\(wrongTick) Test #\(testCaseNumber) Expected: \(expectedValue.characterArray) Your output: \(output.characterArray)")
        }
        testCaseNumber += 1
    }
}

let input1 = "All-convoYs-9-be:Alert1."
let expected1 = "Epp-gsrzsCw-3-fi:Epivx5."
let output1 = RotationalCipher(backing: input1).cipher(withRotationFactor: 4)
RotationalCipher.check(expected1, against: output1)

let input2 = "abcdZXYzxy-999.@"
let expected2 = "stuvRPQrpq-999.@"
let output2 = RotationalCipher(backing: input2).cipher(withRotationFactor: 200)
RotationalCipher.check(expected2, against: output2)

// Add your own test cases here
