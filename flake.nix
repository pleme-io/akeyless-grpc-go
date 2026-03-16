{
  description = "Go gRPC client for interacting with the Akeyless API";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs: (import "${inputs.substrate}/lib/repo-flake.nix" {
    inherit (inputs) nixpkgs flake-utils;
  }) {
    self = inputs.self;
    language = "go";
    builder = "library";
    pname = "akeyless-grpc-go";
    vendorHash = "sha256-JSDU/ieSHMr/j4qvk8TsBDO/vdR18czNWJCr8K/9vsI=";
    description = "Go gRPC client for interacting with the Akeyless API";
    homepage = "https://github.com/pleme-io/akeyless-grpc-go";
  };
}
