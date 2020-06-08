package main

import (
	"fmt"
	"net"
)

func main() {
	// Bind the port.
	ServerAddr, err := net.ResolveUDPAddr("udp", ":10001")
	if err != nil {
		fmt.Println("Error binding port!")
	}

	ServerConn, _ := net.ListenUDP("udp", ServerAddr)
	defer ServerConn.Close()

	fmt.Println("Listening on : 10001 port")

	buf := make([]byte, 1024)
	for {
		n, _, _ := ServerConn.ReadFromUDP(buf)
		fmt.Println(string(buf[0:n]))
	}
}
