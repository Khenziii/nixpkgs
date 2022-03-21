{ lib, stdenv, fetchurl, ocaml, findlib, ocamlbuild, topkg, cmdliner, seq, stdlib-shims }:

if !lib.versionAtLeast ocaml.version "4.05"
then throw "fmt is not available for OCaml ${ocaml.version}"
else

stdenv.mkDerivation rec {
  version = "0.9.0";
  pname = "ocaml${ocaml.version}-fmt";

  src = fetchurl {
    url = "https://erratique.ch/software/fmt/releases/fmt-${version}.tbz";
    sha256 = "sha256-8fsggFoi3XWhN9cnBKNw53ic9r32OUjmgX0cImwUEmE=";
  };

  nativeBuildInputs = [ ocaml findlib ocamlbuild topkg ];
  buildInputs = [ topkg ];
  propagatedBuildInputs = [ cmdliner seq stdlib-shims ];

  strictDeps = true;

  inherit (topkg) buildPhase installPhase;

  meta = with lib; {
    homepage = "https://erratique.ch/software/fmt";
    license = licenses.isc;
    description = "OCaml Format pretty-printer combinators";
    inherit (ocaml.meta) platforms;
    maintainers = [ maintainers.vbgl ];
  };
}
