package main

import (
	"context"
	"fmt"
	"net"
	"os/signal"
	"strings"
	"syscall"

	"github.com/gen2brain/beeep"
)

var icon []byte

func main() {
	beeep.AppName = "Mousedroid"
	icon = loadIcon()

	fmt.Printf("listening on %s\n", getLocalIP())
	go listenUDP(createDevice())
	go listenTCP()
	startSystray()

	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()
	<- ctx.Done()

	fmt.Println("recieved interrupt, stopping...")
}

func getLocalIP() string {
	conn, err := net.Dial("udp", "8.8.8.8:80")
	if err != nil {
		return "127.0.0.1"
	}
	defer conn.Close()
	return strings.Split(conn.LocalAddr().String(), ":")[0]
}

