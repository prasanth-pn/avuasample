package db

import (
	"context"
	"log"

	"github.com/edgedb/edgedb-go"
	"honnef.co/go/tools/config"
)

var (
	client *edgedb.Client
)

func ConnectDB(cnf config.Config) *edgedb.Client {
	ctx := context.Background()
	opts := edgedb.Options{
		Database:    cnf.DBName,
		User:        cnf.DBUser,
		Concurrency: 4,
	}

	// Create a new client instance
	var err error
	client, err = edgedb.CreateClient(ctx, opts)
	if err != nil {
		log.Fatalf("failed to create edgedb client  %v", err)
	}
	defer client.Close()

	log.Println("Connected to EdgeDB")

	return client
}
