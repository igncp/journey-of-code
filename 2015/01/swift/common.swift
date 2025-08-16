import Foundation

let file = "../input_1.txt"

func getInputChars() -> [String] {
  let fileURL = URL(
    fileURLWithPath: file,
    relativeTo: URL(fileURLWithPath: FileManager.default.currentDirectoryPath))

  do {
    let inputText = try String(contentsOf: fileURL, encoding: .utf8)
    return inputText.map { String($0) }
  } catch {
    print("Error reading file: \(error)")
    exit(1)
  }
}

func getFloorNumber(inputChars: [String]) -> Int {
  let (currentFloor, _) = traverseFloors(inputChars: inputChars)
  return currentFloor
}

func getPositionOfFloor(targetFloor: Int, inputChars: [String]) -> Int {
  var position = 0
  let (_, _) = traverseFloors(inputChars: inputChars) { currentFloor, pos in
    if currentFloor == targetFloor {
      position = pos
      return true
    }
    return false
  }
  return position
}

private func traverseFloors(
  inputChars: [String],
  completion: (
    (Int, Int) -> Bool
  )? = nil
) -> (Int, Int) {
  var currentFloor = 0
  var position = 0

  for char in inputChars {
    if char == "(" {
      currentFloor += 1
    } else if char == ")" {
      currentFloor -= 1
    }
    position += 1

    if let completion = completion {
      let shouldStop = completion(currentFloor, position)
      if shouldStop {
        break
      }
    }
  }

  return (currentFloor, position)
}
