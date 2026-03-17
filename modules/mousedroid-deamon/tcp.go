package main

import (
	"fmt"
	"net"
	"os"
	"strings"

	"github.com/gen2brain/beeep"
)

func parseName(data string) string {
	return strings.Split(data, "/")[1]
}

func listenTCP() {

	server, err := net.Listen("tcp", ":6969")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer server.Close()

	fmt.Println("start tcp listening...")
	for {
		conn, err := server.Accept()
		if err != nil {
			panic(err)
		}

		buffer := make([]byte, 128)
		n, err := conn.Read(buffer)
		if err != nil {
			fmt.Printf("cant read incoming buffer: %s\n", err)
			continue
		}
		data := string(buffer[:n])
		fmt.Printf("device connected: %s\n", data)
		name := parseName(data)

		err = beeep.Notify("new device", fmt.Sprintf("%s connected", name), icon)
		if err != nil {
			panic(err)
		}
	}
}
