# akeyless-grpc-go

Go package for interacting with the Akeyless API using gRPC

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Example](#example)
- [License](#license)

## Introduction

The `akeyless/grpc` library provides a convenient way to interact with the Akeyless API using gRPC.

## Installation

To use `akeyless_grpc` in your project, run the following command `go get github.com/akeylesslabs/akeyless-grpc-go`


## Example

```go
ctx := context.Background()
conn, err := grpc.NewClient("localhost:8085", grpc.WithTransportCredentials(insecure.NewCredentials()))

if err != nil {
    t.Error(err)
}

client := NewAkeylessV2ServiceClient(conn)

authOutput, err := client.Auth(ctx, &AuthRequest{
    Body: &Auth{
        AccessId:   "**********",
        AccessKey:  "**********",
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
```

### License

This project is licensed under the Apache License 2.0. See the LICENSE file for details.
