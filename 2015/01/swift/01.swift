import Foundation

@main
struct Exercise01 {
  static func main() {
    let inputChars = getInputChars()
    let floorNumber = getFloorNumber(inputChars: inputChars)

    assert(floorNumber == 138, "Invalid count: \(floorNumber)")
  }
}
