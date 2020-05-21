package main

import (
	"fmt"
	"net"
)

func main() {
	ServerConn, _ := net.ListenUDP("udp", &net.UDPAddr{IP: []byte{0, 0, 0, 0}, Port: 1001, Zone: ""})
	defer ServerConn.Close()
	buf := make([]byte, 1024)
	for {
		n, addr, _ := ServerConn.ReadFromUDP(buf)
		fmt.Println("Received ", string(buf[0:n]), " from ", addr)
	}
}
