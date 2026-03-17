package main

import (
	"fmt"
	"os"
	"path/filepath"
)

func tryToLoadIcon() (icon []byte, err error) {
	execpath, err := os.Executable()
	if err != nil {
		return nil, err
	}
	realpath, err := filepath.EvalSymlinks(execpath)
	if err != nil {
		return nil, err
	}
	iconpath := filepath.Join(filepath.Dir(filepath.Dir(realpath)), "icon.png")
	icon, err = os.ReadFile(iconpath)
	return
}

func loadIcon() []byte {
	icon, err := tryToLoadIcon()
	if err != nil {
		fmt.Printf("cant load icon: %s\n", err)
	}
	return icon
}
