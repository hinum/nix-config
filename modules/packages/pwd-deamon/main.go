package main

import (
	"log"
	"net"
	"os"
	"os/signal"
	"syscall"
)

func main() {

	sockfile := "/tmp/pwd-deamon.sock"
	socket, err := net.Listen("unix", sockfile)
	if err != nil {
		log.Fatal(err)
	}
	pwdstr, err := os.UserHomeDir()
	if err != nil {
		pwdstr = "/"
	}
	pwd := []byte(pwdstr)

	// Cleanup the sockfile.
	c := make(chan os.Signal, 1)

	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	go func() {
		<-c
		os.Remove(sockfile)
		os.Exit(1)
	}()

	println("listening...")
	for {
		// Accept an incoming connection.
		conn, err := socket.Accept()
		if err != nil {
			log.Fatal(err)
		}

		// Handle the connection in a separate goroutine.
		go func(conn net.Conn) {

			defer conn.Close()
			buf := make([]byte, 4096)
			n, err := conn.Read(buf)
			if err != nil {
				log.Fatal(err)
			}
			if buf[0] != '/' {
				_, err = conn.Write(pwd)
				return
			}
			pwd = buf[:n]
			println(string(pwd))

		}(conn)
	}
}
