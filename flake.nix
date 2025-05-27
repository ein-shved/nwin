{
  description = ''
    Neovim UI that creates a new OS window for each Neovim window
  '';

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        nwin = pkgs.callPackage ./. { };
      in
      {
        packages = {
          inherit nwin;
          default = nwin;
        };
        formatter = pkgs.nixfmt-rfc-style;
        devShells.default = pkgs.mkShell {
          inputsFrom = [ nwin ];
          packages = with pkgs; [
            rust-analyzer
            rustfmt
          ];
        };
      }
    );
}
