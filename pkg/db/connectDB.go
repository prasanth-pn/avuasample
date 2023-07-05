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
	err=client.Execute(context.Background(),
`INSERT Beta {
	name:=<str>$0,
}`,"prasanth")

log.Fatalf("erroor in db %v",err)


	return client
}

