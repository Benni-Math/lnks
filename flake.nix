{
  description = "Open browser bookmarks from the command line.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ...}: (
    {
      overlays.default = (final: prev:
        {
          lnks = self.packages.${final.system}.default;
        }
      );
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          overlays = [
            self.overlays.default
          ];
          inherit system;
        };

        buildInputs = with pkgs; [ fzf vim ];
        devInputs = with pkgs; [ shellcheck vhs ];
      in
      {
        packages.default = pkgs.writeShellApplication {
          name = "lnks";
          runtimeInputs = buildInputs;
          text = builtins.readFile ./lnks.sh;
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [
            self.packages.${system}.default
          ];

          packages = buildInputs ++ devInputs;
        };
      }
    )
  );
}
