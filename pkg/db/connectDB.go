package db

import (
	"context"
	"log"

	"github.com/edgedb/edgedb-go"
)

var (
	client *edgedb.Client
)

// Connect initializes the EdgeDB connection
func ConnectDB() *edgedb.Client {
	ctx := context.Background()
	opts := edgedb.Options{
		Database:    "edgedb",
		User:        "edgedb",
		Concurrency: 4,
	}

	// Create a new client instance
	var err error
	client, err = edgedb.CreateClient(ctx, opts)
	if err != nil {
		return client
	}

	log.Println("Connected to EdgeDB")
	err = client.Execute(context.Background(),
		`INSERT Beta {
	name:=<str>$0,
}`, "prasanth")

	return client
}
func Close() {
	if client != nil {
		client.Close()
		log.Println("Disconnected from EdgeDB")
	}
}
