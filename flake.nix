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

  outputs = { self, nixpkgs, substrate, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      mkGoLibraryCheck = (import "${substrate}/lib/go-library-check.nix").mkGoLibraryCheck;
    in {
      checks.default = mkGoLibraryCheck pkgs {
        pname = "akeyless-grpc-go";
        version = "0.0.0-dev";
        src = self;
        vendorHash = "sha256-JSDU/ieSHMr/j4qvk8TsBDO/vdR18czNWJCr8K/9vsI=";
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [ go gopls gotools ];
      };
    });
}
