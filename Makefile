.PHONY: clean build run

all: build

clean:
	-rm -rf _build
	-rm -rf bin/.merlin
	-rm -rf src/.merlin

build:
	jbuilder build bin/main.exe

run: build
	./_build/default/bin/main.exe
