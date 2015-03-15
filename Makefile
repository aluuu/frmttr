clean:
	rm -rf ./_build *.native *.byte

build:
	ocaml ./pkg/build.ml native=true native-dynlink=true

test: build
	./test.native

.PHONY: build test clean
