import Foundation

@main
struct Tests {
  static func g(s: String) -> [String] {
    return s.map { String($0) }
  }

  static func testGetFloorNumber() {
    let testCases: [(String, Int)] = [
      ("(())", 0), ("()()", 0), ("(((", 3), ("(()(()(", 3),
    ]

    for (input, expected) in testCases {
      let inputChars = g(s: input)
      let result = getFloorNumber(inputChars: inputChars)
      assert(result == expected, "Expected \(expected), got \(result), for input \(input)")
    }
  }

  static func main() {
    testGetFloorNumber()
  }
}
