.PHONY: clean build run install

all: build

clean:
	-rm -rf _build
	-rm -rf bin/.merlin
	-rm -rf src/.merlin

build:
	jbuilder build bin/main.exe

install:
	jbuilder build @install

run: build
	./_build/default/bin/main.exe
