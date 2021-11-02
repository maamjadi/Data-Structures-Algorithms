/*
 Minimum Length Substrings
 You are given two strings s and t. You can select any substring of string s and rearrange the characters of the selected substring. Determine the minimum length of the substring of s such that string t is a substring of the selected substring.
 Signature
 int minLengthSubstring(String s, String t)
 Input
 s and t are non-empty strings that contain less than 1,000,000 characters each
 Output
 Return the minimum length of the substring of s. If it is not possible, return -1
 Example
 s = "dcbefebce"
 t = "fd"
 output = 5
 Explanation:
 Substring "dcbef" can be rearranged to "cfdeb", "cefdb", and so on. String t is a substring of "cfdeb". Thus, the minimum length required is 5.
 */


// Add any extra import statements you may need here


// Add any helper functions you may need here


extension String {
    func minLengthOfRearrangedSubstring(containing substring: String) -> Int {
        Array("String").firstIndex(of: <#T##Character#>)
  // Write your code here
  return 0

    }
}











// These are the tests we use to determine if the solution is correct.
// You can add your own at the bottom.

var testCaseNumber = 1

private func check(_ expectedValue: Int, matches output: Int) {
  let rightTick = "\u{2713}"
  let wrongTick = "\u{2717}"

  let result = expectedValue == output
  if result {
      print("\(rightTick) Test #\(testCaseNumber)")
  } else {
      print("\(wrongTick) Test #\(testCaseNumber) Expected: \(expectedValue) Your output: \(output)")
  }
  testCaseNumber += 1
}

let s1 = "dcbefebce"
let t1 = "fd"
let output1 = s1.minLengthOfRearrangedSubstring(containing: t1)
check(5, matches: output1)

let s2 = "bfbeadbcbcbfeaaeefcddcccbbbfaaafdbebedddf"
let t2 = "cbccfafebccdccebdd"
let output2 = s2.minLengthOfRearrangedSubstring(containing: t2)
check(-1, matches: output2)

// Add your test cases here

