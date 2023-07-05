package main

import (
	"log"

	"github.com/prasanthpn-pn/avua-erecruitement/pkg/di"
)

func main() {

	server, err := di.InitiallizeEvent()

	if err != nil {
		log.Fatal("failed to initialize the files")
	}

	server.Start()

}
