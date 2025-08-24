package main

import (
	"joc201504/src"
	"strconv"
)

func main() {
	content, err := src.GetFileContent()
	if err != nil {
		panic(err)
	}

	result := src.GetNumberForPrefix("00000", content)

	if result != 254575 {
		stringNum := strconv.Itoa(result)
		panic("Invalid result: " + stringNum)
	}
}
