with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "modmail";
  buildInputs = [ python314 pipenv railway ];
}