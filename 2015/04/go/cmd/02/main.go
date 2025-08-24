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

	result := src.GetNumberForPrefix("000000", content)

	if result != 1038736 {
		stringNum := strconv.Itoa(result)
		panic("Invalid result: " + stringNum)
	}
}
