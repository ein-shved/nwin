{
  rustPlatform,

  SDL2,
  SDL2_ttf,
  fontconfig,
  pkg-config,
}:
rustPlatform.buildRustPackage {
  pname = "nwin";
  version = "0.1.0";

  buildInputs = [
    SDL2
    SDL2_ttf
    fontconfig
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  src = builtins.path {
    filter = (
      path: type:
      let
        bn = baseNameOf path;
      in
      bn != "flake.nix" && bn != "flake.lock" && bn != "default.nix"
    );
    path = ./.;
  };
  cargoLock.lockFile = ./Cargo.lock;
}
