with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "acre-bootstrap-api";
  buildInputs = with pkgs; [
    go
    gnumake
    kind
    kubectl
  ];
  hardeningDisable = [ "fortify" ];
  shellHook = ''
    export GOPRIVATE=github.com/activatedio/*
  '';
}
