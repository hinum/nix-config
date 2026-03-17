package main

import (
	"fmt"
	"net"
	"os"

	"github.com/holoplot/go-evdev"
)

const (
	LCLICK = 0x01
	RCLICK = 0x02
	DOWN = 0x03
	UP = 0x04
	MOVE = 0x05
	SCROLL = 0x06
	KEYPRESS = 0x07
	HSCROLL = 0x08
	ZOOM = 0x09 // not supported
	MEDIA = 0x0A
)

func listenUDP(device *evdev.InputDevice) {
	server, err := net.ListenPacket("udp", ":6969")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer server.Close()

	fmt.Println("start udp listening...")
	for {
		buffer := make([]byte, 8)
		n, _, err := server.ReadFrom(buffer)

		if err != nil {
			fmt.Printf("cant read incoming buffer: %s\n", err)
		}
		handleInput(device, buffer[:n])
	}
}

func handleInput(device *evdev.InputDevice, packet []byte) {
	switch packet[0] {
	case LCLICK:
		mousedown(device, evdev.BTN_LEFT,90001)
		mouseup(device, evdev.BTN_LEFT,90001)
	case RCLICK:
		mousedown(device, evdev.BTN_RIGHT,90002)
		mouseup(device, evdev.BTN_RIGHT,90002)
	
	case DOWN:
		mousedown(device, evdev.BTN_LEFT,90001)
	case UP: 
		mouseup(device, evdev.BTN_LEFT,90001)

	case MOVE:
		dx := -int8(packet[1])
		dy := -int8(packet[2])
		mousemove(device, dx, dy)

	case SCROLL:
		mousescroll(device, int8(packet[1]))
	case HSCROLL:
		mousehscroll(device, int8(packet[1]))

	case MEDIA:
		mediapress(device, packet[1])
	case KEYPRESS:
		keypress(device, packet[1], packet[2])
	}
}
