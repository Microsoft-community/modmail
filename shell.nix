with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "modmail";
  buildInputs = [ python311 pipenv railway ];
}