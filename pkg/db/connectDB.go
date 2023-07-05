package db

import (
	"context"
	"log"

	"github.com/edgedb/edgedb-go"
)

var (
	client *edgedb.Client
)

func ConnectDB() *edgedb.Client {
	ctx := context.Background()
	opts := edgedb.Options{
		Database:    "edgedb",
		User:        "edgeeb",
		Concurrency: 3,
	}

	// Create a new client instance
	var err error
	client, err = edgedb.CreateClient(ctx, opts)
	if err != nil {
		log.Fatalf("failed to create edgedb client  %v", err)
	}

	log.Println("Connected to EdgeDB")

	return client
}

