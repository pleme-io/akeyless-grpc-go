package models

import (
	"context"
	"fmt"
	"testing"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func Test_Client(t *testing.T) {

	ctx := context.Background()
	conn, err := grpc.NewClient("localhost:8085", grpc.WithTransportCredentials(insecure.NewCredentials()))

	if err != nil {
		t.Error(err)
	}

	client := NewAkeylessV2ServiceClient(conn)

	authOutput, err := client.Auth(ctx, &AuthRequest{
		Body: &Auth{
			AccessId:   "p-ec1reno45hi7al",
			AccessKey:  "DRXHZTGMaYFVIPUNryKV5Bjb1rprjlis3wNIupzA7sI=",
			AccessType: "access_key",
		},
	})

	if err != nil {
		t.Error(err)
	}

	listItemsResp, err := client.ListItems(ctx, &ListItemsRequest{Body: &ListItems{Token: authOutput.Token}})

	if err != nil {
		return
	}

	for _, item := range listItemsResp.Items {
		fmt.Println(item.ItemName)
	}

	secretResponse, err := client.GetSecretValue(ctx, &GetSecretValueRequest{Body: &GetSecretValue{Token: authOutput.Token, Names: []string{"/MyFirstSecret"}}})

	if err != nil {
		return
	}

	for secretName, item := range secretResponse.Data.Fields {
		fmt.Println(secretName, item.GetStringValue())
	}

}
