{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc843" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, hspec, stdenv }:
      mkDerivation {
        pname = "authauth";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [ base hspec ];
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
