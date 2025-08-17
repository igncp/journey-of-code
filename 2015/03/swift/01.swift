import Foundation

@main
struct Exercise01 {
  static func main() {
    let inputChars = getInputChars()
    let numOfPositions = getNumOfPositions(directions: inputChars, entities: 1)

    assert(numOfPositions == 2592, "Invalid numOfPositions: \(numOfPositions)")
  }
}
