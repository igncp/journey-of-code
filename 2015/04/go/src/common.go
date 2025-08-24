package src

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"os"
	"strings"
)

func GetNumberForPrefix(prefix string, content string) int {
	count := -1
	prefix_len := len(prefix)

	for {
		count++
		data := fmt.Appendf(nil, "%s%d", content, count)
		hash := md5.Sum(data)
		hashString := hex.EncodeToString(hash[:])
		if hashString[:prefix_len] == prefix {
			return count
		}
	}
}

func GetFileContent() (string, error) {
	fileContent, err := os.ReadFile("../input.txt")

	if err != nil {
		return err.Error(), err
	}

	return strings.TrimSpace(string(fileContent)), nil
}
